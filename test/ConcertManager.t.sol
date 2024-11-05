// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contracts/ConcertManager.sol";

contract ConcertManagerTest is Test {
    ConcertManager concertManager;

    function setUp() public {
        concertManager = new ConcertManager();
    }

    // Sample test case in ConcertManager.t.sol
    function testCreateConcert() public {
        concertManager.createConcert("Artist", "Venue", block.timestamp + 1 weeks, 1 ether, 1);

        // Assert that the concert count has incremented
        uint256 currentConcertCount = concertManager.concertCount(); // Assuming concertCount is public or you have a getter
        assertEq(currentConcertCount, 1); // Check if the concert count is now 1
    }
}
