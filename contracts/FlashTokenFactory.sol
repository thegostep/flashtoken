pragma solidity 0.5.16;

import "./FlashToken.sol";
import "https://github.com/erasureprotocol/erasure-protocol/blob/v1.2.0/contracts/modules/Spawner.sol";

/// @title FlashTokenFactory
/// @author Stephane Gosselin (@thegostep)
/// @notice An Erasure style factory for Wrapping FlashTokens
contract FlashTokenFactory is Spawner {
    uint256 private _tokenCount;
    address private _templateContract;
    mapping(address => address) private _baseToFlash;
    mapping(address => address) private _flashToBase;
    mapping(uint256 => address) private _idToBase;

    event TemplateSet(address indexed templateContract);
    event FlashTokenCreated(
        address indexed token,
        address indexed flashToken,
        uint256 tokenID
    );

    /// @notice Initialize factory with template contract.
    function setTemplate(address templateContract) public {
        require(_templateContract == address(0));
        _templateContract = templateContract;
        emit TemplateSet(templateContract);
    }

    /// @notice Create a FlashToken wrap for any ERC20 token
    function createFlashToken(address token)
        public
        returns (address flashToken)
    {
        require(token != address(0), "cannot wrap address 0");
        if (_baseToFlash[token] != address(0)) {
            return _baseToFlash[token];
        } else {
            require(_baseToFlash[token] == address(0), "token already wrapped");

            flashToken = _flashWrap(token);

            _baseToFlash[token] = flashToken;
            _flashToBase[flashToken] = token;
            _tokenCount += 1;
            _idToBase[_tokenCount] = token;

            emit FlashTokenCreated(token, flashToken, _tokenCount);
            return flashToken;
        }
    }

    /// @notice Initialize instance
    function _flashWrap(address token) private returns (address flashToken) {
        FlashToken template;
        bytes memory initCalldata = abi.encodeWithSelector(
            template.initialize.selector,
            token
        );
        return Spawner._spawn(address(this), _templateContract, initCalldata);
    }

    // Getters

    /// @notice Get FlashToken contract associated with given ERC20 token
    function getFlashToken(address token)
        public
        view
        returns (address flashToken)
    {
        return _baseToFlash[token];
    }

    /// @notice Get ERC20 token contract associated with given FlashToken
    function getBaseToken(address flashToken)
        public
        view
        returns (address token)
    {
        return _flashToBase[flashToken];
    }

    /// @notice Get ERC20 token contract associated with given FlashToken ID
    function getBaseFromID(uint256 tokenID)
        public
        view
        returns (address token)
    {
        return _idToBase[tokenID];
    }

    /// @notice Get count of FlashToken contracts created from this factory
    function getTokenCount() public view returns (uint256 tokenCount) {
        return _tokenCount;
    }

}
