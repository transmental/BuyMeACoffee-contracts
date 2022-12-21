// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract BuyMeACoffee {
    //Event to emit when memo created.
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo struct.
    struct Memo{
        address from;
        uint256 timestamp;
        string name;
        string message;
    }
    //list of all memos from friends.
    Memo[] memos;

    //Address of contract deployer.
    address payable owner;

    //deploy logic
    constructor() {
        owner = payable(msg.sender);
    }

    //buy a coffee for contract owner
    //name of the coffee buyer
    //message from coffee buyer
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy me a coffee with no moneez");

        //add memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        //emit log event when created
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /**
    *send the entire balance stored to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /**
    retrieve all the memos stored
     */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}
