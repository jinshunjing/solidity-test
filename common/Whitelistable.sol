
import "./Ownable.sol";

/**
 * @title Whitelistable Token
 * @dev Allows accounts to be whitelisted by a "whitelister" role
*/
contract Whitelistable is Ownable {

    address public whitelister;

    mapping(address => bool) internal whitelisted;

    event WhitelisterChanged(address indexed newWhitelister);

    event Whitelisted(address indexed _account);
    event UnWhitelisted(address indexed _account);

    /**
     * @dev Throws if called by any account other than the whitelister
    */
    modifier onlyWhitelister() {
        require(msg.sender == whitelister);
        _;
    }

    /**
     * @dev Throws if argument account is not whilelisted
     * @param _account The address to check
    */
    modifier onlyWhitelisted(address _account) {
        require(whitelisted[_account] == true);
        _;
    }

    /**
     * @dev Checks if account is whitelisted
     * @param _account The address to check
    */
    function isWhitelisted(address _account) public view returns (bool) {
        return whitelisted[_account];
    }

    /**
     * @dev Adds account to whitelist
     * @param _account The address to add
    */
    function whitelist(address _account) public onlyWhitelister {
        whitelisted[_account] = true;
        emit Whitelisted(_account);
    }

    /**
     * @dev Removes account from whitelist
     * @param _account The address to remove
    */
    function unWhitelist(address _account) public onlyWhitelister {
        whitelisted[_account] = false;
        emit UnWhitelisted(_account);
    }

    /**
     * @dev Update the whitelister
     * @param _newWhitelister Address of the new whitelister
    */
    function updateWhitelister(address _newWhitelister) public onlyOwner {
        require(_newWhitelister != address(0));
        whitelister = _newWhitelister;
        emit WhitelisterChanged(whitelister);
    }
}
