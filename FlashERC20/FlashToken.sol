pragma solidity 0.5.16;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/math/SafeMath.sol";

interface IBorrower {
    function executeOnFlashMint(uint256 amount) external;
}

/// @title FlashToken
/// @author Stephane Gosselin (@thegostep), Austin Williams (@Austin-Williams)
/// @notice Anyone can be rich... for an instant.
contract FlashToken is ERC20 {
    using SafeMath for uint256;

    ERC20 internal _baseToken;
    address private _factory;

    /////////////////////////////
    // Template Initialization //
    /////////////////////////////

    /// @notice Modifier which only allows to be `DELEGATECALL`ed from within a constructor on initialization of the contract.
    modifier initializeTemplate() {
        // set factory
        _factory = msg.sender;

        // only allow function to be `DELEGATECALL`ed from within a constructor.
        uint32 codeSize;
        assembly {
            codeSize := extcodesize(address)
        }
        require(codeSize == 0, "must be called within contract constructor");
        _;
    }

    /// @notice Initialize the instance with the base token
    function initialize(address baseToken) public initializeTemplate() {
        _baseToken = ERC20(baseToken);
    }

    /// @notice Get the address of the factory for this clone.
    /// @return factory address of the factory.
    function getFactory() public view returns (address factory) {
        return _factory;
    }

    /// @notice Get the address of the base token for this clone.
    /// @return factory address of the base token.
    function getBaseToken() public view returns (address baseToken) {
        return address(_baseToken);
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
            _baseToken.balanceOf(address(this)) >= totalSupply(),
            "redeemability was broken"
        );
    }

    /// @notice Deposit baseToken
    function deposit(uint256 amount) public {
        require(
            _baseToken.transferFrom(msg.sender, address(this), amount),
            "transfer in failed"
        );
        _mint(msg.sender, amount);
    }

    /// @notice Withdraw baseToken
    function withdraw(uint256 amount) public {
        _burn(msg.sender, amount); // reverts if `msg.sender` does not have enough CT-baseToken
        require(_baseToken.transfer(msg.sender, amount), "transfer out failed");
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
