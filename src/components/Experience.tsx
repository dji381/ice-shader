import { OrbitControls } from "@react-three/drei";
import IceGround from "./iceGround";

const Experience = () => {
  return (
    <>
      <ambientLight intensity={1.5}/>
      <OrbitControls />
      <IceGround/>
    </>
  );
};

export default Experience;