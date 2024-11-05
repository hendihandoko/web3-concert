import React, { useState } from "react";
import { ethers } from "ethers";

const TicketPurchase = ({ contract }) => {
  const [concertId, setConcertId] = useState("");
  const [ticketCount, setTicketCount] = useState(1);

  const purchaseTickets = async () => {
    const transaction = await contract.purchaseTicket(concertId, ticketCount, {
      value: ethers.utils.parseEther((ticketCount * 1).toString()), // Assuming 1 ETH per ticket for simplicity
    });
    await transaction.wait();
    alert("Tickets purchased successfully!");
  };

  return (
    <div>
      <h2>Purchase Tickets</h2>
      <input
        type="number"
        placeholder="Concert ID"
        value={concertId}
        onChange={(e) => setConcertId(e.target.value)}
      />
      <input
        type="number"
        min="1"
        value={ticketCount}
        onChange={(e) => setTicketCount(e.target.value)}
      />
      <button onClick={purchaseTickets}>Buy Tickets</button>
    </div>
  );
};

export default TicketPurchase;
