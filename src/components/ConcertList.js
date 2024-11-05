import React, { useEffect, useState } from "react";

const ConcertList = ({ contract }) => {
  const [concerts, setConcerts] = useState([]);

  const fetchConcerts = async () => {
    const concertCount = await contract.concertCount();
    const concertList = [];
    for (let i = 0; i < concertCount; i++) {
      const concert = await contract.concerts(i);
      concertList.push(concert);
    }
    setConcerts(concertList);
  };

  useEffect(() => {
    if (contract) {
      fetchConcerts();
    }
  }, [contract]);

  return (
    <div>
      <h2>Upcoming Concerts</h2>
      <ul>
        {concerts.map((concert, index) => (
          <li key={index}>
            <strong>{concert.artist}</strong> at {concert.venue} on{" "}
            {new Date(concert.date * 1000).toLocaleString()}
            <br />
            Ticket Price: {ethers.utils.formatEther(concert.ticketPrice)} ETH
          </li>
        ))}
      </ul>
    </div>
  );
};

export default ConcertList;
