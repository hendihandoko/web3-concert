// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../contracts/ConcertManager.sol";

contract DeployConcertManager is Script {
    function run() external {
        vm.startBroadcast();
        new ConcertManager();
        vm.stopBroadcast();
    }
}
