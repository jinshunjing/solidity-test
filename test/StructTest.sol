pragma solidity ^0.5.2;

contract StructTest {

    struct Funder {
        address addr;
        uint256 amount;
    }

    struct Campaign {
        address payable beneficiary;
        uint256 amount;
        uint8 numFunders;
        mapping (uint8 => Funder) funders;
    }

    uint8 numCampaigns;
    mapping (uint8 => Campaign) campaigns;

    function newCampain(address payable beneficiary) external returns (uint8 campaignId) {
        campaignId = numCampaigns++;

        // new memory and copy to storage
        campaigns[campaignId] = Campaign(beneficiary, 0, 0);
    }

    function contribute(uint8 campainId) external payable {
        // storage
        Campaign storage c = campaigns[campainId];

        c.funders[c.numFunders++] = Funder(msg.sender, msg.value);
        c.amount += msg.value;
    }

    function status(uint8 campainId) external view returns(uint) {
        Campaign storage c = campaigns[campainId];
        return c.amount;
    }
}
