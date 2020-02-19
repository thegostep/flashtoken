pragma solidity 0.5.16;

import "./FlashToken.sol";

contract Borrower {
    FlashToken flashToken = FlashToken(address(0x0)); // address of FlashToken contract

    function executeOnFlashMint(uint256 amount) public {
        require(
            msg.sender == address(flashToken),
            "only FlashToken can execute"
        );

        // execute arbitrary code - must have sufficient balance to pay back loan by end of function execution

    }
}
