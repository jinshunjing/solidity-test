pragma solidity ^0.4.25;

contract association {

    /// @notice Association
    struct Association {
        /// creator of the association
        address creator;

        /// name of the association
        string name;
        /// FIXME: 下列信息不上链，只记录在中心化服务端
        /// 官网，邮箱，电话，Logo，介绍

        /// org chart of the association
        OrgChart orgChart;

        /// governance rules
        GovRule[] govRules;
        /// expense rules
        ExpRule[] expRules;
    }

    /// @notice OrgChart of the association
    /// @dev Roles are predefined. There is no way to add or remove roles.
    ///  角色的分组(管理层，普通成员)不上链，只记录在中心化服务端
    struct OrgChart {
        /// only one president
        address president;
        /// can have more than one vice presidents
        address[] vicePresidents;
        /// members
        address[] members;
    }

    /// @notice Governance rules adopted by the association
    /// @dev 3种不同的治理方式可以抽象成同一种工作流的治理方式
    struct GovRule {
        /// FIXME: 允许的治理规则通过接口预定义，不能动态添加
        Rule id;

        /// name
        string name;

        /// type
        GovType type;

        /// period of expiry of a rule
        /// FIXME: 有效期默认15天
        uint256 expiry;

        /// roles of the proposers
        Role[] proposers;

        /// approval workflow
        /// FIXME: DIRECT为空，VOTE只有一级，WORKFLOW有N级
        Approval[] workflow;
    }

    /// @notice Approval
    struct Approval {
        /// level of the approval within the workflow
        uint8 level;

        /// minimum rate for approval
        /// FIXME: 不用百分比，而是采用M/N
        /// FIXME: WORKFLOW设置为1/N，只需要一个人同意
        uint8 rateM;
        uint8 rateN;

        /// roles of the approvers
        /// FIXME: for VOTE, they are the roles of the voters
        Role[] approvers;
    }

    /// @notice Financial expense rules
    /// @dev special rules for financial expenses
    struct ExpRule {
        /// low bound excluded
        uint256 low;
        /// up bound include
        uint256 up;

        /// governance rule to expend (low, up]
        GovRule rule;
    }

    /// @notice Roles
    enum Role {
        PRESIDENT,
        VP,
        MEMBER
    }

    /// @notice Types of governance rules
    enum GovType {
        /// no rules
        DIRECT,
        /// governance through votes
        VOTE,
        /// governance through approval workflow
        WORKFLOW
    }

    /// @notice Rules
    enum Rule {
        /// 最高管理规则
        SUPER,
        /// 高级治理规则
        ADVANCED,

        /// 变更社长
        CHPRESIDENT,

        /// 变更副社长
        CHVP,

        /// 变更普通成员
        CHMEMBER,

        /// 财务审批
        EXPENSE,

        /// 修改经营信息
        CHINFO,

        /// 关闭组织
        CLOSE
    }

}
