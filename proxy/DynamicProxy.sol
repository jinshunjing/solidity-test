pragma solidity ^0.5.2;

import "./Proxy.sol";

/**
 * @title DynamicProxy
 * @dev This contract implements a proxy that allows to change the
 * target contract to which it will delegate.
 */
contract DynamicProxy is Proxy {
    /**
     * @dev Emitted when the target contract is changed.
     * @param target Address of the new target contract.
     */
    event Changed(address target);

    /**
     * @dev Storage slot with the address of the current target contract.
     * This is the keccak-256 hash of "com.funchain.proxy.target", and is
     * validated in the constructor.
     */
    bytes32 private constant TARGET_SLOT = 0x73cb36133e102e943c058ee4a0c9e34761a53d5c014334eebdd52e71c8df3db3;

    /**
     * @dev Contract constructor.
     * @param _target Address of the target contract.
     */
    constructor(address _target) public {
        assert(TARGET_SLOT == keccak256("com.funchain.proxy.target"));
        _setTarget(_target);
    }

    /**
     * @dev Change the proxy to a new target contract.
     * To be called in the derived contract.
     * @param newTarget Address of the new target contract.
     */
    function _changeTarget(address newTarget) internal {
        _setTarget(newTarget);
        emit Changed(newTarget);
    }

    /**
     * @dev Returns the current target contract.
     * Override the super function.
     * @return Address of the current target contract
     */
    function _target() internal view returns (address targ) {
        bytes32 slot = TARGET_SLOT;
        assembly {
            targ := sload(slot)
        }
    }

    /**
     * @dev Sets the target contract address of the proxy.
     * @param newTarget Address of the new target contract.
     */
    function _setTarget(address newTarget) private {
        bytes32 slot = TARGET_SLOT;
        assembly {
            sstore(slot, newTarget)
        }
    }
}
