pragma solidity ^0.4.24;

contract OrgBlock {

  enum uType {PaymentGateway, Organization, Donor, Retailer}
  address public owner;

  struct User {
      uint id;
      string s;
      uint reputation;
      uint amount_recieved;
      uint amount_spent;
      uint amount_remaining;
      address user_addr;
      uint latest_transaction;
    }

  struct Donation {
    User toOrg;
    string donationNote;
    uint amountDonated;
    uint donValidity;
    uint id;
  }

  struct OrgExpense {
    User fromOrg;
    User toRetail;
    string purpose;
    uint amountSpent;
    uint expValidity;
    uint id;
  }

  mapping(uint => User) public users;
  mapping(uint => Donation) public donations;
  mapping(uint => OrgExpense) public expenses;

  uint public usersCount;
  uint public donationsCount;
  uint public expensesCount;

  uType public uT;

  constructor() public {
    uint Org = 3;
    uint Don = 10;
    uint Ret = 5;
    uint PayG = 1;

    usersCount = 0;
    donationsCount = 0;
    expensesCount = 0;

    owner = msg.sender;

    addUser("PaymentGateway", 0, 0, 0);
  }

  function addUser (string _s, uint _reputation, uint _amount_recieved, uint _amount_spent) public {
      usersCount ++;
      users[usersCount] = User(usersCount, _s, _reputation, _amount_recieved, _amount_spent, 0, 0x000,0);
  }

  function getUsers() public view returns (uint){
    return usersCount;
  }

  function addDonation (uint org_id, uint donor_id, string donationNote, uint amountDonated) public returns (uint){
      require(keccak256(msg.sender) == keccak256(owner));
      for(uint i=0; i<usersCount; i++){
          if(org_id == users[i].id)
            break;
      }
      for(uint j=0; j<usersCount; j++){
          if(donor_id == users[j].id)
            break;
      }

      users[i].amount_recieved += amountDonated;
      users[i].amount_remaining += amountDonated;
      users[j].amount_spent += amountDonated;

      donationsCount ++;
      users[i].latest_transaction = donationsCount;
      users[j].latest_transaction = donationsCount;
      donations[donationsCount] = Donation(users[i], donationNote, amountDonated,1, donationsCount);
      return donationsCount;
  }

  function addExpense (uint org_id, uint retail_id, string purpose, uint amountSpent) public returns (uint){
      require(keccak256(msg.sender) == keccak256(owner));
      for(uint i=0; i<usersCount; i++){
          if(org_id == users[i].id)
            break;
      }
      users[i].amount_spent += amountSpent;
      users[i].amount_remaining -= amountSpent;


      for(uint j=0; j<usersCount; j++){
          if(retail_id == users[j].id)
            break;
      }
      users[j].amount_recieved += amountSpent;


      expensesCount ++;
      users[i].latest_transaction = expensesCount;
      users[j].latest_transaction = expensesCount;
      expenses[expensesCount] = OrgExpense(users[i], users[j], purpose, amountSpent, 1, expensesCount);
      return expensesCount;
  }

  function validateDonation(uint u_id, uint t_id) public{
      for(uint i=0; i<usersCount; i++){
          if(u_id == users[i].id)
            break;
      }
      require(users[i].latest_transaction == t_id);
      for(i=0; i<donationsCount; i++){
          if(t_id == donations[i].id)
            break;
      }
      donations[i].donValidity++;
  }

  function getDonValidity(uint t_id) public view returns(uint) {
      for(uint i=0; i<donationsCount; i++){
          if(t_id == donations[i].id)
            break;
      }
      return donations[i].donValidity;
  }


  function validateExpense(uint u_id, uint t_id) public{
      for(uint i=0; i<usersCount; i++){
          if(u_id == users[i].id)
            break;
      }
      require(users[i].latest_transaction == t_id);
      for(i=0; i<expensesCount; i++){
          if(t_id == expenses[i].id)
            break;
      }
      expenses[i].expValidity++;
  }

  function getExpValidity(uint t_id) public view returns(uint) {
      for(uint i=0; i<expensesCount; i++){
          if(t_id == expenses[i].id)
            break;
      }
      return expenses[i].expValidity;
  }

  function getAmountRecieved(uint org_id) public view returns(uint){
      for(uint i=0; i<usersCount; i++){
          if(org_id == users[i].id)
            break;
      }
      uint ret_value = users[i].amount_recieved;
      return ret_value;
  }

  function getAmountRemaining(uint org_id) public view returns(uint){
      for(uint i=0; i<usersCount; i++){
          if(org_id == users[i].id)
            break;
      }
      uint ret_value = users[i].amount_remaining;
      return ret_value;
  }
}