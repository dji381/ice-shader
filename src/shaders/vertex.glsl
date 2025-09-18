varying vec2 vUv;
varying vec3 vPosition;
varying vec3 vNormalW;
void main() {	
  csm_PositionRaw = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
  vNormalW = (modelMatrix * vec4(normal,0.0)).xyz;
  vPosition = (modelMatrix * vec4(position,1.0)).xyz;
  vUv = uv;
}