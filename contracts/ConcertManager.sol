// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ConcertManager is Ownable {
    struct Concert {
        string artist;
        string venue;
        uint256 date; // Unix timestamp
        uint256 ticketPrice;
        uint256 totalTickets;
        uint256 ticketsSold;
        bool isActive;
    }

    mapping(uint256 => Concert) public concerts; // mapping from concert ID to Concert struct
    uint256 public concertCount; // Total number of concerts

    event ConcertCreated(
        uint256 indexed concertId,
        string artist,
        string venue,
        uint256 date,
        uint256 ticketPrice,
        uint256 totalTickets
    );

    event ConcertUpdated(
        uint256 indexed concertId,
        string artist,
        string venue,
        uint256 date,
        uint256 ticketPrice,
        uint256 totalTickets,
        bool isActive
    );

    constructor() Ownable(msg.sender) {}

    function createConcert(
        string memory _artist,
        string memory _venue,
        uint256 _date,
        uint256 _ticketPrice,
        uint256 _totalTickets
    ) external onlyOwner {
        concertCount++;
        concerts[concertCount] = Concert({
            artist: _artist,
            venue: _venue,
            date: _date,
            ticketPrice: _ticketPrice,
            totalTickets: _totalTickets,
            ticketsSold: 0,
            isActive: true
        });

        emit ConcertCreated(concertCount, _artist, _venue, _date, _ticketPrice, _totalTickets);
    }

    function updateConcert(
        uint256 _concertId,
        string memory _artist,
        string memory _venue,
        uint256 _date,
        uint256 _ticketPrice,
        uint256 _totalTickets,
        bool _isActive
    ) external onlyOwner {
        require(_concertId > 0 && _concertId <= concertCount, "Concert does not exist");
        
        Concert storage concert = concerts[_concertId];
        concert.artist = _artist;
        concert.venue = _venue;
        concert.date = _date;
        concert.ticketPrice = _ticketPrice;
        concert.totalTickets = _totalTickets;
        concert.isActive = _isActive;

        emit ConcertUpdated(_concertId, _artist, _venue, _date, _ticketPrice, _totalTickets, _isActive);
    }

    function getConcert(uint256 _concertId) external view returns (Concert memory) {
        require(_concertId > 0 && _concertId <= concertCount, "Concert does not exist");
        return concerts[_concertId];
    }

    function getAllConcerts() external view returns (Concert[] memory) {
        Concert[] memory allConcerts = new Concert[](concertCount);
        for (uint256 i = 1; i <= concertCount; i++) {
            allConcerts[i - 1] = concerts[i];
        }
        return allConcerts;
    }
}
