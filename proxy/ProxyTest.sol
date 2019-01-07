pragma solidity ^0.5.2;

import "./AdminDynamicProxy.sol";

/**
 * @title ProxyTest
 * @dev This contract tests the proxy features
*/
contract ProxyTest is AdminDynamicProxy {
    /**
     * Contract constructor
     *
     * @param _target address of the target contract.
     */
    constructor(address _target) public AdminDynamicProxy(_target) {
    }
}
