# OrgBlock2018 (Crowdfunding platform)
UCI Blockathon 2018

### Start truffle console
truffle console
<br />
migrate --reset
### Create the app instance
OrgBlock.deployed().then(function(instance){app = instance})
### Create users

![Alt text](https://github.com/hard-fault/OrgBlock2018/blob/master/image.png)

app.addUser("Organization", 0, 0, 0)<t/> [3 organizations]<br />
app.addUser("Vendor", 0, 0, 0)<t/> [3 vendors]<br />
app.addUser("Donor", 0, 0, 0)<t/>  [4 donors]<br />




Consider,<br />
0 - PaymentGateway <br /><br />
1 - Wikimedia,     2 - Americare,     3 - Republicans<br /><br />
4 - AWS,     5 - Walmart,    6 - Bren Event mgmt.<br /><br />
7 - Batman <br />

<br /><br />
app.getUsers()
<br /><br />


### Simulate donation

app.addDonation(org_id, don_id,  <message>, amount, sender_address)<br />
app.addDonation(1, 7,  "Because I am batman", 5000, {from: web3.eth.accounts[3]})<br />
> fails! only PaymentGateway can create the transaction block<br /><br />


app.addDonation(1, 7,  "Because I am batman", 5000, {from: web3.eth.accounts[0]}) <br />
> transaction with id=1 created.<br />

### Participants validate the transaction block 
#### (validity is to ensure the block integrity. v = 3.  PGateway, Sender, Reciever)
app.getDonValidity( t_id )  <br />
app.getDonValidity( 1 )  <br />
> transaction_id = 1, validity must be = 1<br />

app.validateDonation(org_id, t_id)  <br />
app.validateDonation(1, 1)  <br />
> Wikipedia acknowledges the transaction.<br />


app.validateDonation(don_id, t_id)  <br />
app.validateDonation(7, 1)<br />
> Batman acknowledges the transaction.<br />

app.getDonValidity( t_id )  <br />
app.getDonValidity( 1 )<br />
> must be 3!<br />

### Check the balance
app.getAmountRecieved( org_id )<br />
app.getAmountRecieved( 1 )<br /><br />

app.getAmountRecieved( org_id )<br />
app.getAmountRemaining( 1 )<br />

### Simulate expense
app.addExpense(org_id, vend_id, message, amount)<br />
app.addExpense(1, 4, "Wikipedia is yet to decentralize :/ ", 2000)<br />


### Participants validate the transaction block 
#### (validity must be 3! PGateway, Sender, Reciever)
app.validateExpense(org_id, t_id)  <br />
app.validateExpense(1, 1)<br /><br />

app.validateExpense(don_id, t_id)  <br />
app.validateExpense(4, 1)<br /><br />

app.getDonValidity( t_id )  <br />
app.getExpValidity( 1 )<br />
> must be 3!<br /><br />


### Check the balance
app.getAmountRemaining( org_id )<br />
app.getAmountRemaining( 1 )<br />


### Why would one join OrgBlock(Because it is a win-win! strategy)
##### Easy to integrate
##### Decentralized and automated rating for the Non-profits.
##### Donors are encouraged to donate (it's transparent).
##### Everyone in chain gets incentivized for participating.





