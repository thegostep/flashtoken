pragma solidity 0.5.16;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/ownership/Ownable.sol";
import "./FlashMintableERC20.sol";

contract Borrower is Ownable {

    FlashMintableERC20 fmERC20 = FlashMintableERC20(address(0x0)); // address of FlashMintableERC20 contract

    function beginFlashMint(uint256 amount) public onlyOwner {
        fmERC20.flashMint(amount);
    }

    function executeOnFlashMint(uint256 amount) public {
        require(msg.sender == address(fmERC20), "only FlashMintableERC20 can execute");

        // When this executes, this contract will have `amount` more FMT tokens.
        // Do whatever you want with those tokens here.
        // You can even redeem them for the underlying by calling `fmERC20.redeem(someAmount)`
        // But you must make sure this contract holds at least `amount` FMT tokens before this function finishes executing
        // or else the transaction will be reverted by the `FlashMintableERC20.flashMint` function.
    }
}