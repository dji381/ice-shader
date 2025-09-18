uniform vec3 uIceColor;
uniform vec3 uCrackColor;
uniform float uTime;
uniform float uFrostAmount;
uniform float uFresnelPower;
uniform sampler2D uCrackTexture;
uniform float uCrackStrenght;
uniform float uRimBoost;
varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormalW;
// --- Fonctions auxiliaires ---
float randomValue(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

float interpolate(float a, float b, float t) {
    return mix(a, b, t); // mix() = (1-t)*a + t*b
}

float valueNoise(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    f = f * f * (3.0 - 2.0 * f); // easing

    vec2 c0 = i + vec2(0.0, 0.0);
    vec2 c1 = i + vec2(1.0, 0.0);
    vec2 c2 = i + vec2(0.0, 1.0);
    vec2 c3 = i + vec2(1.0, 1.0);

    float r0 = randomValue(c0);
    float r1 = randomValue(c1);
    float r2 = randomValue(c2);
    float r3 = randomValue(c3);

    float bottom = interpolate(r0, r1, f.x);
    float top = interpolate(r2, r3, f.x);
    return interpolate(bottom, top, f.y);
}

// --- SimpleNoise 2D avec UV et Scale ---
float simpleNoise(vec2 uv, float scale) {
    float t = 0.0;

    float freq = pow(2.0, 0.0);
    float amp = pow(0.5, 3.0 - 0.0);
    t += valueNoise(uv * scale / freq) * amp;

    freq = pow(2.0, 1.0);
    amp = pow(0.5, 3.0 - 1.0);
    t += valueNoise(uv * scale / freq) * amp;

    freq = pow(2.0, 2.0);
    amp = pow(0.5, 3.0 - 2.0);
    t += valueNoise(uv * scale / freq) * amp;

    return t;
}
float saturateFloat(float x) {
    return clamp(x, 0.0, 1.0);
}
float fresnel(float amount, vec3 normal, vec3 view){
	return pow(
		1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0),
		amount
	);
}
void main() {
    vec3 viewDir = normalize(cameraPosition - vPosition);
    vec3 normaln = normalize(vNormalW);
    float n = simpleNoise(vUv, 30.0);
    float d = uFrostAmount * n;
    n = 1.0 - d;
    vec3 color = uIceColor * n;
    float nSaturate = max(.91,saturateFloat(n));
    vec4 crackTexture = texture2D(uCrackTexture,vUv);
    crackTexture = vec4(crackTexture.xyz,crackTexture.a * uCrackStrenght);
    crackTexture.xyz *= uCrackColor;
    float fresnel = fresnel(uFresnelPower,normaln,viewDir);
    crackTexture *= fresnel; 
    crackTexture.xyz *= uRimBoost;
    csm_Emissive = crackTexture.xyz;
    csm_DiffuseColor = vec4(vec3(mix(color,vec3(uCrackColor * uRimBoost),crackTexture.a)) , nSaturate);
}