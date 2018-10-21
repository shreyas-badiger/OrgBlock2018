pragma solidity ^0.4.24;

contract OrgBlock {

  enum uType {Organization,Donor,Retailer,PaymentGateway}

  struct User {
      uint id;
      string s;
      uint reputation;
      uint amount_recieved;
      uint amount_spent;
    }

  struct Donation {
    User fromDonor;
    User toOrg;
    string donationNote;
    uint amountDonated;
    uint donationValidity;
  }

  struct OrgExpense {
    User fromOrg;
    User toRetail;
    string purpose;
    uint amountSpent;
    uint expValidity;
  }

  mapping(uint => User) public users;
  mapping(uint => Donation) public donations;
  mapping(uint => OrgExpense) public expenses;

  uint public usersCount = 0;
  uint public donationsCount = 0;
  uint public expensesCount = 0;

  uType public uT;

  constructor() public {
    uint Org = 3;
    uint Don = 10;
    uint Ret = 5;
    uint PayG = 1;

    usersCount = 0;
    amount = 0;
    validity = 0;

    for (uint i=0; i<Org; i++) {
      addUser("Organization", 0, 0, 0);
    }
    
    for (i=0; i<Don; i++) {
      addUser("Donor", 0, 0, 0);
    }

    for (i=0; i<Ret; i++) {
      addUser("Retailer", 0, 0, 0);
    }

    addUser("PaymentGateway", 0, 0, 0);
  }

  function addUser (string _s, uint _reputation, uint _amount_recieved, uint _amount_spent) private{
      usersCount ++;
      users[usersCount] = User(usersCount, _s, _reputation, _amount_recieved, _amount_spent);
  }

  function getUsers() public view returns (uint){
    return usersCount;
  }

  function addDonation (User _fromDonor, User _toOrg, string _donationNote, uint _amountDonated) public view returns (uint){
      donationsCount ++;
      donations[donationCount] = Donation(_fromDonor, _toOrg, _donationNote, _amountDonated);
      donations[donationCount].fromDonor.amount_recieved += _amountDonated;
      return donationsCount;
  }

  function addExpense (User _fromOrg, User _toRetail, string _purpose, uint _amountSpent) public view returns (uint){
      expensesCount ++;
      expenses[expensesCount] = OrgExpense(_fromOrg, _toRetail, _purpose, _amountSpent);
      expenses[expensesCount].fromDonor.amount_spent += _amountSpent;
      return expensesCount;
  }
}