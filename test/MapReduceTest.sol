pragma solidity ^0.5.2;

library Utils {
    function map(
        uint256[] memory self,
        function (uint256) pure returns(uint256) f
    )
        internal pure returns(uint256[] memory r)
    {
        r = new uint256[](self.length);
        for (uint8 i = 0; i < self.length; i++) {
           r[i] = f(self[i]);
        }
    }

    function reduce(
        uint256[] memory self,
        function (uint256, uint256) pure returns(uint256) f
    )
        internal pure returns(uint256 r)
    {
        r = self[0];
        for (uint8 i = 1; i < self.length; i++) {
            r = f(r, self[i]);
        }
    }
}

contract MapReduceTest {
    using Utils for *;

    function square(uint256 v) internal pure returns(uint256) {
        return v * v;
    }

    function sum(uint256 a, uint256 b) internal pure returns(uint256) {
        return a + b;
    }

    function testMapReduce() external returns(uint256) {
        uint256[] memory arrays = new uint256[](6);
        for (uint8 i = 0; i < arrays.length; i++) {
            arrays[i] = i + 1;
        }
        return arrays.map(square).reduce(sum);
    }
}
