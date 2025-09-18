uniform vec3 uIceColor;
uniform float uTime;
uniform float uFrostAmount;
varying vec2 vUv;
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
void main() {
    float n = simpleNoise(vUv, 30.0);
    float d = uFrostAmount * n;
    n = 1.0 - d;
    vec3 color = uIceColor * n;
    float nSaturate = saturateFloat(n);
    csm_DiffuseColor = vec4(vec3(color) , nSaturate);
}