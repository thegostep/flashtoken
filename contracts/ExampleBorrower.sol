pragma solidity 0.5.16;

import "./FlashToken.sol";
import "./IBorrower.sol";

contract Borrower is IBorrower {
    FlashToken flashToken = FlashToken(address(0x0)); // address of FlashToken contract

    // required to receive ETH in case you want to `redeem` some fmETH for real ETH during `executeOnFlashMint`
    function() external payable {}

    function executeOnFlashMint(uint256 amount) external {
        require(
            msg.sender == address(flashToken),
            "only FlashToken can execute"
        );

        // execute arbitrary code - must have sufficient balance to pay back loan by end of function execution

    }
}
