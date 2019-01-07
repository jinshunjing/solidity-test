pragma solidity ^0.5.2;

/**
 * @title Proxy
 * @dev Implements proxy of target contract, with proper forwarding of return
 * values and bubbling of failures.
 * It defines a fallback function that delegates all calls to the address
 * returned by the abstract _target() internal function.
 */
contract Proxy {
    /**
     * @dev Fallback function.
     * Invocation of target contract is performed within the fallback function.
     */
    function () payable external {
        _fallback();
    }

    /**
     * @return The Address of the target contract.
     */
    function _target() internal view returns (address);

    /**
     * @dev Invokes the target contract.
     * This is a low level function that doesn't return to its internal call site.
     * It will return to the external caller whatever the target contract returns.
     * @param target Address of the target contract.
     */
    function _invoke(address target) internal {
        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.
            calldatacopy(0, 0, calldatasize)

            // Call the implementation.
            // out and outsize are 0 because we don't know the size yet.
            let result := delegatecall(gas, target, 0, calldatasize, 0, 0)

            // Copy the returned data.
            returndatacopy(0, 0, returndatasize)

            // delegatecall returns 0 on error.
            switch result
            case 0 { revert(0, returndatasize) }
            default { return(0, returndatasize) }
        }
    }

    /**
     * @dev Function that is run as the first thing in the fallback function.
     * Can be redefined in derived contracts to add functionality.
     */
    function _doFallback() internal {
    }

    /**
     * @dev fallback implementation.
     * Do the fallback if required, and then invoke the target contract.
     */
    function _fallback() internal {
        _doFallback();
        _invoke(_target());
    }
}
