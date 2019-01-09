pragma solidity ^0.5.2;

library Set {

    // library操作的结构体
    struct Data {
        mapping(uint256 => bool) flags;
    }

    /**
     * @dev
     * @param self 结构体
     * @param value
     * @return
     */
    function insert(Data storage self, uint256 value) public returns(bool) {
        if (self.flags[value]) {
            return false;
        }
        self.flags[value] = true;
        return true;
    }
}

contract LibrayTest {
    using Set for Set.Data;

    // 结构体
    Set.Data room;

    function register(uint256 value) external returns(bool) {
        // 第一个参数是调用者自己
        return room.insert(value);
    }
}
