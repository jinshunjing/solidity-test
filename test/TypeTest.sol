pragma solidity ^0.5.2;

contract TypeTest {

    function testInt() external {
        // 十进制
        uint256 ia = 123_456;

        // 十六进制
        uint16 ib = 0xff_ee;

        // 科学计数法
        uint256 ic = 2e10;
    }

    function testString() external {
        // 字符串
        bytes2 ba = "AB";
        bytes2 bb = 'CD';

        // 二进制
        bytes2 be = hex"0e0e";
        bytes2 bf = hex'0f0f';

        // 长度可变
        bytes memory bc = "EFG";
        string memory bd = "HIJ";
    }

}
