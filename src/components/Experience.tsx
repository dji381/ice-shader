import { Environment, OrbitControls } from "@react-three/drei";
import { EffectComposer, Bloom } from "@react-three/postprocessing";
import IceGround from "./iceGround";

const Experience = () => {
  return (
    <>
      <Environment preset="night" />
      <OrbitControls />
      <IceGround />

      {/* Post-process avec bloom */}
      <EffectComposer>
        <Bloom
          intensity={1.5} 
          luminanceThreshold={0.2}
          luminanceSmoothing={0.9}
        />
      </EffectComposer>
    </>
  );
};

export default Experience;
