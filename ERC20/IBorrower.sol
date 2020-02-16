pragma solidity 0.5.16;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/ownership/Ownable.sol";

contract IBorrower is Ownable {
    function executeOnFlashMint(uint256 amount) public;
}