import vertexShader from "@/shaders/vertex.glsl";
import fragmentShader from "@/shaders/fragment.glsl";
import * as THREE from "three";
import CustomShaderMaterial from 'three-custom-shader-material'
import { useGLTF, useTexture } from "@react-three/drei";
import { useRef } from "react";
import { useFrame } from "@react-three/fiber";
const IceGround = () => {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const shaderRef = useRef<any>(null!)
  const map = useTexture('/texture/CrackTexture.png');
  const iceNormal = useTexture('/texture/IceNormal.png');
  const {nodes} = useGLTF('/model/suzanne.glb');
  useFrame((state) => {
    if (shaderRef.current?.uniforms) {
      shaderRef.current.uniforms.uTime.value = state.clock.elapsedTime
    }
  })
  return (
    <mesh position={[0, 0, 0]} geometry={(nodes.Suzanne as THREE.Mesh).geometry} >
      <CustomShaderMaterial<typeof THREE.MeshStandardMaterial>
        baseMaterial={THREE.MeshStandardMaterial}
        ref={shaderRef}
        vertexShader={vertexShader}
        fragmentShader={fragmentShader}
        uniforms={{
          uIceColor: {value: new THREE.Color(0x1f74cf).convertLinearToSRGB()},
          uFrostAmount: {value: 0.5},
          uTime: {value: 0.0},
          uCrackTexture: {value: map},
          uCrackStrenght:{value: 18.0},
          uRimBoost:{value: 2.5},
          uFresnelPower: {value: 5.0},
          uCrackColor:{value: new THREE.Color(0x1fc5cf).convertLinearToSRGB()}
        }}
        transparent={true}
        normalMap={iceNormal}
        normalScale={new THREE.Vector2(2,2)}
        roughness={0.2}
      />
    </mesh>
  );
};

export default IceGround;
