import "./App.css";
import { Canvas } from "@react-three/fiber";
import Experience from "@/components/Experience";

function App() {
  return (
    <Canvas shadows camera={{ position: [0, 3, 3], near: 0.1, fov: 40 }}>
      <color attach="background" args={["#000000"]} />
      <Experience/>
    </Canvas>
  );
}

export default App;
