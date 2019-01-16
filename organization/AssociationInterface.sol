pragma solidity ^0.4.25;

interface Association {

    /// @notice Create the association
    function create() external;

    /// @notice Change rule
    function changeRule(
        string id,
        uint8 type,
        uint8[] proposers,
        bytes32[] workflow
    );

    /// @notice 变更组织架构，包括：变更社长，添加副社长，添加普通成员，撤销副社长，开除普通成员
    function changeOrgChart(

    );


}
