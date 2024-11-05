import React, { useState } from "react";
import { ethers } from "ethers";

const TicketResale = ({ contract }) => {
  const [ticketId, setTicketId] = useState("");
  const [resalePrice, setResalePrice] = useState("");

  const resellTicket = async () => {
    const transaction = await contract.resellTicket(
      ticketId,
      ethers.utils.parseEther(resalePrice)
    );
    await transaction.wait();
    alert("Ticket listed for resale!");
  };

  return (
    <div>
      <h2>Resell Tickets</h2>
      <input
        type="text"
        placeholder="Ticket ID"
        value={ticketId}
        onChange={(e) => setTicketId(e.target.value)}
      />
      <input
        type="text"
        placeholder="Resale Price (ETH)"
        value={resalePrice}
        onChange={(e) => setResalePrice(e.target.value)}
      />
      <button onClick={resellTicket}>List Ticket for Resale</button>
    </div>
  );
};

export default TicketResale;
