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

  function addDonation (uint org_id, string donationNote, uint amountDonated) public returns (uint){
      for(uint i=0; i<usersCount; i++){
          if(org_id == users[i].id)
            break;
      }

      donationsCount ++;
      donations[donationsCount] = Donation(users[i], donationNote, amountDonated,1);
      donations[donationsCount].toOrg.amount_recieved += amountDonated;
      return donationsCount;
  }

  function addExpense (uint org_id, uint retail_id, string purpose, uint amountSpent) public returns (uint){

      for(uint i=0; i<usersCount; i++){
          if(org_id == users[i].id)
            break;
      }

      for(uint j=0; j<usersCount; j++){
          if(retail_id == users[j].id)
            break;
      }
      expensesCount ++;
      expenses[expensesCount] = OrgExpense(users[i], users[j], purpose, amountSpent,1);
      expenses[expensesCount].fromOrg.amount_spent += amountSpent;
      expenses[expensesCount].toRetail.amount_recieved += amountSpent;
      return expensesCount;
  }

  function createBlock(string From, string To, string Remark, uint Amount, uint Validity) public returns (string) {
    return To;
  }
}