// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./ICryptoDevs.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CryptoDevToken is ERC20, Ownable {
    ICryptoDevs CryptoDevNFT; //creating a variable that can keep track of our Token.

    //_cryptoDevsContract: It is the NFT contract that we deployed previously, we want to call the contract to access its functions
    constructor(address _cryptoDevsContract) ERC20("XENON", "XNN") {
        CryptoDevNFT = ICryptoDevs(_cryptoDevsContract); // Specifying which cryptodev contract you want to track
    }

    //To claim the num of tokens
    function claim() public {
        address sender = msg.sender;
        uint balance = CryptoDevNFT.balanceOf(sender);
        require(balance > 0, "You don't own any");

        for (uint i = 0; i < balance; i++) {
            uint tokenId = CryptoDevsNFT
        }
    }
}
