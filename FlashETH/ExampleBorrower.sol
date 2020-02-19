pragma solidity 0.5.16;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/ownership/Ownable.sol";
import "./FlashMintableETH.sol";

contract Borrower is Ownable {

    FlashMintableETH fmETH = FlashMintableETH(address(0x0)); // address of FlashMintableETH contract

    // required to receive ETH in case you want to `redeem` some fmETH for real ETH during `executeOnFlashMint`
    function () external payable {}

    // call this function to fire off your flash mint
    function beginFlashMint(uint256 amount) public onlyOwner {
        fmETH.flashMint(amount);
    }

    // this is what executes during your flash mint
    function executeOnFlashMint(uint256 amount) public {
        require(msg.sender == address(fmETH), "only FlashMintableETH can execute");

        // When this executes, this contract will have `amount` more fmETH tokens.
        // Do whatever you want with those tokens here.
        // You can even redeem them for ETH by calling `fmETH.redeem(someAmount)`
        // But you must make sure this contract holds at least `amount` fmETH before this function finishes executing
        // or else the transaction will be reverted by the `FlashMintableETH.flashMint` function.
    }
}