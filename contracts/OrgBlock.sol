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

  mapping(uint => User) public users;

  uint public usersCount = 0;
  uType public uT;

  struct Donation {
    User fromDonorUser;
    User toOrgUser;
    string donationNote;
    uint amountDonated;
    uint donationValidity;
  }

  User public fromDonorUser;
  User public toOrgUser;
  string public donationNote;
  uint public amountDonated;
  uint public donationValidity=1;
  uint public donationCount = 0;
  uint public totalDonationAmount=0;


 function addDonation (User fromDonorUser, User toOrgUser, string donationNote, uint amountDonated) private{
      donationCount ++;
      totalDonationAmount+=amountDonated;
      Donations[donationCount] = User(usersCount, _s, _reputation, _amount_recieved, _amount_spent);
  }

  struct OrgExpenditure {
    User fromOrgUser;
    User toRetaiUser;
    String purpose;
    uint amountSpent;
    uint expValidity;
  }

    string public fromOrgUser;
    string public toOrgUser;
    string public purpose;
    uint public amountSpent;
    uint public expValidity=1;


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

  function createBlock(string From, string To, string Remark, uint Amount, uint Validity) public returns (string) {
    from = From;
    to = To;
    remark = Remark;
    amount = Amount;
    validity = Validity;

    return to;
  }

  function totalAmountRecieved() public view returns (uint) {
    return amount;
  }

}