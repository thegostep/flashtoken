pragma solidity 0.5.16;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/ownership/Ownable.sol";
import "./CrazyTownERC20.sol";

contract Borrower is Ownable {

    CrazyTownERC20 crazyTownERC20 = CrazyTownERC20(address(0x0)); // address of CrazyTownERC20 contract

    function beginFlashMint(uint256 amount) public onlyOwner {
        crazyTownERC20.flashMint(amount);
    }

    function executeOnFlashMint(uint256 amount) public {
        require(msg.sender == address(crazyTownERC20), "only crazyTownETH can execute");

        // When this executes, this contract will have `amount` more CT-Underlying tokens.
        // Do whatever you want with those tokens here.
        // You can even redeem them for the underlying by calling `crazyTownERC20.redeem(someAmount)`
        // But you must make sure this contract holds at least `amount` CT-Underlying before this function finishes executing
        // or else the transaction will be reverted by the `crazyTownERC20.flashMint` function.
    }
}