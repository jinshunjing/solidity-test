
import "./Ownable.sol";

/**
 * @title Pausable
 * @dev Allows contract to be paused
 */
contract Pausable is Ownable {

    address public pauser;

    bool public paused = false;

    event PauserChanged(address indexed newAddress);

    event Pause();
    event Unpause();

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     */
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    /**
     * @dev throws if called by any account other than the pauser
     */
    modifier onlyPauser() {
        require(msg.sender == pauser);
        _;
    }

    /**
     * @dev called by the owner to pause, triggers stopped state
     */
    function pause() onlyPauser public {
        paused = true;
        emit Pause();
    }

    /**
     * @dev called by the owner to unpause, returns to normal state
     */
    function unpause() onlyPauser public {
        paused = false;
        emit Unpause();
    }

    /**
     * @dev update the pauser role
     */
    function updatePauser(address _newPauser) onlyOwner public {
        require(_newPauser != address(0));
        pauser = _newPauser;
        emit PauserChanged(pauser);
    }

}
