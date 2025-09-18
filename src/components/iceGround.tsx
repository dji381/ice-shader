import vertexShader from "@/shaders/vertex.glsl";
import fragmentShader from "@/shaders/fragment.glsl";
import * as THREE from "three";
import CustomShaderMaterial, { type CustomShaderMaterialProps } from 'three-custom-shader-material'
import { useTexture } from "@react-three/drei";
import { useRef } from "react";
import { useFrame } from "@react-three/fiber";
const IceGround = () => {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const shaderRef = useRef<any>(null!)
  const map = useTexture('/texture/CrackTexture.png');
  const iceNormal = useTexture('/texture/IceNormal.png');
  useFrame((state) => {
    if (shaderRef.current?.uniforms) {
      shaderRef.current.uniforms.uTime.value = state.clock.elapsedTime
    }
  })
  return (
    <mesh position={[0, 0, 0]} rotation={[-Math.PI * 0.5, 0, 0]}>
      <planeGeometry args={[1, 1, 10, 10]} />
      <CustomShaderMaterial<typeof THREE.MeshStandardMaterial>
        baseMaterial={THREE.MeshStandardMaterial}
        ref={shaderRef}
        vertexShader={vertexShader}
        fragmentShader={fragmentShader}
        uniforms={{
          uIceColor: {value: new THREE.Color(0x0000ff)},
          uFrostAmount: {value: 0.5},
          uTime: {value: 0.0}
        }}
        color={new THREE.Color(0xff0000)}
        transparent={true}
        normalMap={iceNormal}
        // alphaMap={map}
      />
    </mesh>
  );
};

export default IceGround;
