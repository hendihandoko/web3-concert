// src/App.js
import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
import ConcertManager from "./contracts/ConcertManager.json";

const App = () => {
  const [concertManager, setConcertManager] = useState(null);
  const [provider, setProvider] = useState(null);

  useEffect(() => {
    const init = async () => {
      const { ethereum } = window;
      if (!ethereum) {
        alert("Please install MetaMask!");
        return;
      }

      const provider = new ethers.BrowserProvider(ethereum);
      const signer = await provider.getSigner();
      const contractAddress = "YOUR_CONTRACT_ADDRESS"; // Replace with your contract address

      const contract = new ethers.Contract(
        contractAddress,
        ConcertManager.abi,
        signer
      );
      setConcertManager(contract);
      setProvider(provider);
    };

    init();
  }, []);

  // Add additional functionality (like calling functions on your contract)

  return (
    <div>
      <h1>Web3 Concerts</h1>
      {/* Other components and functionality */}
    </div>
  );
};

export default App;
