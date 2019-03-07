pragma solidity >=0.5;
contract Marketplace {

    struct User {
        uint balance;
        bool active;
    }

    address chairperson;

    mapping(address => User) users;
    mapping(address => bytes32) hashData;

    constructor() public {
        chairperson = msg.sender;
        users[chairperson].active = true;
        users[chairperson].balance = 500;
    }


    function register(address user) public {
        /// Only chairperson is allowed to register new users
        require(msg.sender == chairperson);
         /// User must not exist
        require(!users[user].active);
        users[user].active = true;
        users[user].balance = 500;
    }

    function unregister(address user) public {
        /// Only chairperson is allowed to unregister users
        require(msg.sender == chairperson);
         /// User must be active
        require(users[user].active);
        users[user].active = false;
        users[user].balance = 0;
    }


    function settlePayment(uint amount, address seller) public {
        /// both seller and buyer must be active
        require(users[msg.sender].active  && users[seller].active);
        require(users[msg.sender].balance >= amount);
        users[msg.sender].balance-=amount;
        users[seller].balance+=amount;
    }

    function addDeposit(uint amount) public {
        /// user must be active
        require(users[msg.sender].active);
        users[msg.sender].balance+=amount;
    }

    function buy(bytes32 data) public {
      hashData[msg.sender]=data;
    }

    function viewBalance() public view returns (uint) {
        /// user must be active
        require(users[msg.sender].active);
        return users[msg.sender].balance;
    }

}
