pragma solidity 0.5.16;

import "./FlashETH.sol";
import "./FlashToken.sol";
import "./FlashTokenFactory.sol";

contract FlashDeployer {
    event Deployed(
        address indexed flashTokenFactory,
        address indexed flashTokenTemplate,
        address indexed flashETH
    );

    constructor(string memory saltstring) public {
        // generate salt
        bytes32 salt = keccak256(bytes(saltstring));
        // deploy contracts
        address flashETH = _executeCreate2(type(FlashETH).creationCode, salt);
        address template = _executeCreate2(type(FlashToken).creationCode, salt);
        address factory = _executeCreate2(
            type(FlashTokenFactory).creationCode,
            salt
        );
        // set factory template
        FlashTokenFactory(factory).setTemplate(template);
        emit Deployed(factory, template, flashETH);
    }

    function _executeCreate2(bytes memory code, bytes32 salt)
        private
        returns (address instance)
    {
        assembly {
            instance := create2(callvalue, add(0x20, code), mload(code), salt)
        }
        return instance;
    }
}
