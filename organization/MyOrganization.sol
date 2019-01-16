pragma solidity ^0.4.25;

import "github.com/seeplayerone/dapp-bin/library/organization.sol";

/// @dev this is a sample to demostrate how to create a simple organization contract on FLOW
///  it is recommended to inherit Oragnization contract which is provided by FLOW Kernel
contract MyOrganization is Organization {
    /// @dev aclAddresses and aclRoles are used to demostrate the ACL capibility provided by Organization
    address[] aclAddresses;
    string[] aclRoles;

    string public constant ROLE_SAMPLE = "ROLE_SAMPLE";
    string public constant FUNCTION_HASH_SAMPLE = "FUNCTION_HASH_SAMPLE";

    /// @dev constructor of the contract
    ///  intial acl settings are configured in the constructor
    /// @dev note that the constructor design will be SIMPLIFIED in the future
    ///  registry and instructions settings will be moved to Organization contract in Kernel
    constructor(string organizationName) Organization(organizationName)
    public {
        aclAddresses = new address[](0);
        aclAddresses.push(msg.sender);

        aclRoles = new string[](0);
        aclRoles.push(ROLE_SAMPLE);

        configureAddressRoleInternal(msg.sender, ROLE_SAMPLE, OpMode.Add);
        configureFunctionAddressInternal(FUNCTION_HASH_SAMPLE, msg.sender, OpMode.Add);
        configureFunctionRoleInternal(FUNCTION_HASH_SAMPLE, ROLE_SAMPLE, OpMode.Add);
    }

    /// @notice {"cost":1000}
    /// @dev use notice to determine the cost of the function
    /// @dev only qualified addresses are allowed to call this function
    function function1() public authAddresses(aclAddresses) {
        /// @dev call registry and get a unique organization id
        ///  which is prerequisite of asset creation and management
        register();
    }

    /// @notice {"cost":1000}
    /// @dev only qualified roles are allowed to call this function
    function function2() public authRoles(aclRoles) {
        /// @dev create an indivisible asset whose inner asset index is 1 and initial amount is 10000
        create(0, 1, 10000);
    }

    /// @notice {"cost":1000}
    /// @dev dynamic acl setting by functionHash
    function function3() public authFunctionHash(FUNCTION_HASH_SAMPLE) {
        /// @dev mint more asset whose inner asset index is 1 and additional issuance amount is 10000
        mint(1, 10000);
    }
}
