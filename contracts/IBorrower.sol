pragma solidity 0.5.16;

interface IBorrower {
    function executeOnFlashMint(uint256 amount) external;
}
