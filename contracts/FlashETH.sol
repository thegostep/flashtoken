pragma solidity 0.5.16;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/math/SafeMath.sol";
import "./IBorrower.sol";

/// @title FlashETH
/// @author Stephane Gosselin (@thegostep), Austin Williams (@Austin-Williams)
/// @notice Anyone can be rich... for an instant. Like FlashToken, but with ETH.
contract FlashETH is ERC20 {
    using SafeMath for uint256;

    string public name = "FlashEther";
    string public symbol = "FlashETH";
    uint8 public decimals = 18;

    /// @notice Deposit ETH with fallback
    function() external payable {
        _mint(msg.sender, msg.value);
    }

    /// @notice Deposit ETH
    function deposit() public payable {
        _mint(msg.sender, msg.value);
    }

    /// @notice Withdraw ETH
    function withdraw(uint256 amount) public {
        _burn(msg.sender, amount); // reverts if `msg.sender` does not have enough fmETH
        msg.sender.transfer(amount);
    }

    //////////////
    // flashing //
    //////////////

    /// @notice Modifier which allows anyone to mint flash tokens.
    /// @notice An arbitrary number of flash tokens are minted for a single transaction.
    /// @notice Reverts if insuficient tokens are returned.
    modifier flashMint(uint256 amount) {
        // mint tokens and give to borrower
        _mint(msg.sender, amount); // reverts if `amount` makes `_totalSupply` overflow

        // execute flash fuckening
        _;

        // burn tokens
        _burn(msg.sender, amount); // reverts if `msg.sender` does not have enough units of the FMT

        // sanity check (not strictly needed)
        require(
            address(this).balance >= totalSupply(),
            "redeemability was broken"
        );
    }

    /// @notice Executes flash mint and calls strandard interface for transaction execution
    function softFlashFuck(uint256 amount) public flashMint(amount) {
        // hand control to borrower
        IBorrower(msg.sender).executeOnFlashMint(amount);
    }

    /// @notice Executes flash mint and calls arbitrary interface for transaction execution
    function hardFlashFuck(
        address target,
        bytes memory targetCalldata,
        uint256 amount
    ) public flashMint(amount) {
        (bool success, ) = target.call(targetCalldata);
        require(success, "external call failed");
    }
}
