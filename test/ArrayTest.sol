pragma solidity ^0.5.2;

contract ArrayTest {

    /**
    * @dev Array literal
    */
    function arrayLiteral() external pure returns (bool) {
        uint8[2] memory us = [65, 66];
        assert(us.length == 2);
        assert(us[0] == 65);
        assert(us[1] == 66);

        bytes2 bs = "AB";
        assert(bs.length == 2);
        assert(bs[0] == 'A');
        assert(uint8(bs[1]) == 66);

        return true;
    }

    /**
    * @dev Allocate memory array
    * @param len Length of array
    */
    function allcMemArray(uint256 len) external pure returns (bool) {
        bytes memory bs = new bytes(len);
        assert(bs.length == len);

        bs[0] = 0x41;
        assert(bs[0] == 'A');

        return true;
    }

}
