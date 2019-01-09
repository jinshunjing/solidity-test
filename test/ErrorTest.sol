pragma solidity ^0.5.2;

contract ErrorTest {

    function testRequire(uint256 num) external pure returns(uint256) {
        // 返回错误信息
        require(num > 256, "Number is too small");
        return num / 2;
    }

    function testAssert(uint256 num) external pure returns(uint256) {
        uint256 a = num / 2;

        // 没有错误信息
        // 消耗所有的gas
        assert(a * 2 == num);
        return a;
    }
}
