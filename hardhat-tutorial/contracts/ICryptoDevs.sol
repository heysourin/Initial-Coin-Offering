// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICryptoDevs {
    function tokenOfOwnerByIndex(
        address owner,
        uint index
    ) external view returns (uint tokenId); //Uses mapping

    function balanceOf(address owner) external view returns (uint balance);
}
