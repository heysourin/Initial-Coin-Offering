// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./ICryptoDevs.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CryptoDevToken is ERC20, Ownable {
    ICryptoDevs CryptoDevNFT; //creating a variable that can keep track of our Token.
    //_cryptoDevsContract: It is the NFT contract that we deployed previously, we want to call the contract to access its functions
    uint256 public constant tokensPerNFT = 10 * 10 ** 18;
    uint256 public constant maxTotalSupply = 10000 * 10 ** 18;
    uint256 public constant tokenPrice = 0.001 ether;

    mapping(uint256 => bool) public tokenIdsClaimed;//tokenIdsClaimed[id] = t/f

    constructor(address _cryptoDevsContract) ERC20("XENON", "XNN") {
        CryptoDevNFT = ICryptoDevs(_cryptoDevsContract); // Specifying which cryptodev contract you want to track
    }

    function mint(uint256 amount) public payable {
        uint256 _requiredAmount = tokenPrice * amount;
        require(msg.value >= _requiredAmount, "Ether sent is incorrect");

        uint256 amountWithDecimals = amount * 10 ** 18;
        require(
            totalSupply() + amountWithDecimals <= maxTotalSupply,
            "Exceedes the max total supply available"
        );

        _mint(msg.sender, amountWithDecimals);
    }

    //To claim the num of tokens
    function claim() public {
        address sender = msg.sender;
        uint256 balance = CryptoDevNFT.balanceOf(sender);
        require(balance > 0, "You don't own any cryptodev nfts");
        uint256 amount = 0;
        for (uint256 i = 0; i < balance; i++){
            uint256 tokenId = CryptoDevNFT.tokenOfOwnerByIndex(sender, i);
            if (!tokenIdsClaimed[tokenId]) {
                amount += 1;
                tokenIdsClaimed[tokenId] = true;
            }
        }
        require(amount > 0, "You have already claimed");
        _mint(msg.sender, amount * tokensPerNFT);
    }

    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "Nothing to withdraw, contract balance empty");

        address _owner = owner();
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    receive() external payable {}

    fallback() external payable {}
}
