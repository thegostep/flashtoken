pragma solidity 0.5.16;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/ownership/Ownable.sol";
import "CT-ETH.sol";

contract Borrower is Ownable {

    CrazyTownETH crazyTownETH = CrazyTownETH(address(0x0)); // address of CrazyTownETH contract

    function beginFlashMint(uint256 amount) public onlyOwner {
        crazyTownETH.flashMint(amount);
    }

    function executeOnFlashMint(uint256 amount) public {
        require(msg.sender == address(crazyTownETH), "only crazyTownETH can execute");

        // When this executes, this contract will have `amount` more CT-ETH tokens.
        // Do whatever you want with those tokens here.
        // You can even redeem them for ETH by calling `crazyTownETH.redeem(someAmount)`
        // But you must make sure this contract holds at least `amount` CT-ETH before this function finishes executing
        // or else the transaction will be reverted by the `crazyTownETH.flashMint` function.
    }
}