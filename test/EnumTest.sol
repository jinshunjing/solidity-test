pragma solidity ^0.4.0;

contract EnumTest {
    enum Color {
        Red,
        Yellow,
        Green
    }

    Color public foreground = Color.Red;

    function testEnum() external view returns(uint256) {
        return uint256(foreground);
    }
}
