pragma solidity ^0.5.2;

import "./DynamicProxy.sol";

/**
 * @title AdminDynamicProxy
 * @dev This contract combines an dynamic proxy with an authorization
 * mechanism for administrative tasks.
 * All external functions in this contract must be guarded by the
 * `ifAdmin` modifier. See ethereum/solidity#3864 for a Solidity
 * feature proposal that would enable this to be done automatically.
 */
contract AdminDynamicProxy is DynamicProxy {
    /**
     * @dev Emitted when the administration has been transferred.
     * @param previousAdmin Address of the previous admin.
     * @param newAdmin Address of the new admin.
     */
    event AdminChanged(address previousAdmin, address newAdmin);

    /**
     * @dev Storage slot with the admin of the contract.
     * This is the keccak-256 hash of "com.funchain.proxy.admin", and is
     * validated in the constructor.
     */
    bytes32 private constant ADMIN_SLOT = 0x9babeb79c911ae7f201cb6f79469f7ea3f17ad99c88e6e05401285c06018843d;

    /**
     * @dev Modifier to check whether the `msg.sender` is the admin.
     * If it is, it will run the function. Otherwise, it will delegate the call
     * to the target contract.
     */
    modifier ifAdmin() {
        if (msg.sender == _admin()) {
            _;
        } else {
            _fallback();
        }
    }

    /**
     * Contract constructor.
     * It sets the `msg.sender` as the proxy administrator.
     * @param _target address of the target contract.
     */
    constructor(address _target) DynamicProxy(_target) public {
        assert(ADMIN_SLOT == keccak256("com.funchain.proxy.admin"));
        _setAdmin(msg.sender);
    }

    /**
     * @return The address of the proxy admin.
     */
    function admin() external view returns (address) {
        return _admin();
    }

    /**
     * @return The address of the target contract.
     */
    function target() external view returns (address) {
        return _target();
    }

    /**
     * @dev Changes the admin of the proxy.
     * Only the current admin can call this function.
     * @param newAdmin Address to transfer proxy administration to.
     */
    function changeAdmin(address newAdmin) external ifAdmin {
        require(newAdmin != address(0), "Cannot change the admin of a proxy to the zero address");
        _setAdmin(newAdmin);
        emit AdminChanged(_admin(), newAdmin);
    }

    /**
     * @dev Change the target contract.
     * Only the admin can call this function.
     * @param newTarget Address of the new target contract.
     */
    function changeTarget(address newTarget) external ifAdmin {
        _changeTarget(newTarget);
    }

    /**
     * @return The admin slot.
     */
    function _admin() internal view returns (address adm) {
        bytes32 slot = ADMIN_SLOT;
        assembly {
            adm := sload(slot)
        }
    }

    /**
     * @dev Sets the address of the proxy admin.
     * @param newAdmin Address of the new proxy admin.
     */
    function _setAdmin(address newAdmin) internal {
        bytes32 slot = ADMIN_SLOT;
        assembly {
            sstore(slot, newAdmin)
        }
    }

    /**
     * @dev Only fall back when the sender is not the admin.
     */
    function _doFallback() internal {
        require(msg.sender != _admin(), "Cannot call fallback function from the proxy admin");
        super._doFallback();
    }
}
