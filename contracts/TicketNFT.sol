// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";

contract TicketNFT is ERC721URIStorage, ReentrancyGuard {
   
    uint256 private _ticketIdCounter;

    address public concertOwner;
    uint256 public ticketPrice;
    mapping(uint256 => bool) public resaleTickets;

    constructor(string memory _concertName) ERC721(_concertName, "TICKET") {
        concertOwner = msg.sender;
    }

    modifier onlyConcertOwner() {
        require(msg.sender == concertOwner, "Only concert owner can call this function");
        _;
    }

    function mintTicket(address _to) external payable nonReentrant {
        require(msg.value >= ticketPrice, "Insufficient funds to purchase ticket");

        uint256 ticketId = _ticketIdCounter;
        _ticketIdCounter++;
        _safeMint(_to, ticketId);
    }

    function listForResale(uint256 _ticketId, uint256 _price) external nonReentrant {
        require(ownerOf(_ticketId) == msg.sender, "Only owner can resell the ticket");
        resaleTickets[_ticketId] = true;
        ticketPrice = _price;
    }

    function buyResaleTicket(uint256 _ticketId) external payable nonReentrant {
        require(resaleTickets[_ticketId] == true, "Ticket not listed for resale");
        require(msg.value >= ticketPrice, "Insufficient funds to buy resale ticket");

        address seller = ownerOf(_ticketId);
        _transfer(seller, msg.sender, _ticketId);
        payable(seller).transfer(msg.value);
        resaleTickets[_ticketId] = false;
    }

    function verifyTicketOwner(uint256 _ticketId) external view returns (bool) {
        return ownerOf(_ticketId) == msg.sender;
    }
}

