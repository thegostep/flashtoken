pragma solidity 0.5.16;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.3.0/contracts/math/SafeMath.sol";
import "./IBorrower.sol";

// @notice A simple token backed 1-to-1 with ETH. So market price should be 1 CT-ETH == 1 ETH.
// Allows for instant "FlashMints" that are akin to flash loans:
// User can mint any number of tokens into their account for a single transaction, so long as they
// are then burned before the end of the transaction.
// Given that the market price should be 1 CT-ETH == 1 ETH, this means anyone can be a quadrillionaire for an instant.
contract CrazyTownERC20 is ERC20 {

    using SafeMath for uint256;

    ERC20 internal _underlying;

    constructor(address underlying) public {
        _underlying = ERC20(underlying);
    }

    // mints CT-Underlying in 1-to-1 correspondence with the underlying token
    function mint(uint256 amount) public {
        require(_underlying.transferFrom(msg.sender, address(this), amount), "transfer in failed");
        _mint(msg.sender, amount);
    }

    // redeems CT-Underlying 1-to-1 for Underlying
    function redeem(uint256 amount) public {
        _burn(msg.sender, amount); // reverts if `msg.sender` does not have enough CT-Underlying
        require(_underlying.transfer(msg.sender, amount), "transfer out failed");
    }

    // allows anyone to mint an arbitrary number of tokens into their account for a single transaction
    // burns those tokens at the end of the transaction
    // reverts if borrower account doesn't have enough tokens to burn by the end of the transaction
    function flashMint(uint256 amount) public {
        // mint tokens and give to borrower
        _mint(msg.sender, amount); // reverts if `amount` makes `_totalSupply` overflow

        // hand control to borrower
        IBorrower(msg.sender).executeOnFlashMint(amount);

        // burn tokens
        _burn(msg.sender, amount); // reverts if `msg.sender` does not have enough CT-ETH
    }
}