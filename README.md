# OrgBlock2018
UCI Blockathon 2018

## Start truffle console
truffle console

## Create the app instance
OrgBlock.deployed().then(function(instance){app = instance})

## Create users
1,2,3, app.addUser("Organization", 0, 0, 0)
4,5,6, app.addUser("Retail", 0, 0, 0)
7,8,9,10, app.addUser("Donor", 0, 0, 0)

Consider,
1 - Wikipedia,  2 - Americare,  3 - Republicans
4 - AWS,  5 - Walmart, 6 - Bren Event mgmt.
7 - Donald

## Simulate donation
app.addDonation(1,7,"Thanks Wiki",5000, {from: web3.eth.accounts[3]}) 
>>>> fails! only PaymentGateway can create the transaction block

app.addDonation(1,7,"Thanks Wiki",5000, {from: web3.eth.accounts[0]}) 
>>>> transaction with id=1 created.

## Participants validate the transaction block (validity must be 3! PGateway, Sender, Reciever)
app.getDonValidity(1)  
>>>transaction_id = 1, validity must be = 1

app.validateDonation(1, 1)  
>>> Wikipedia acknowledges the transaction.


app.validateDonation(7, 1)
>>> Donald acknowledges the transaction.

app.getDonValidity(1)
>>> must be 3!

## Check the balance
app.getAmountRecieved(1)
app.getAmountRemaining(1)

## Simulate expense
app.addExpense(1, 4, "Blankets", 2000)
app.getAmountRemaining(1)

## Participants validate the transaction block (validity must be 3! PGateway, Sender, Reciever)
app.validateExpense(1, 1)
app.validateDonation(4, 1)
app.getExpValidity(1)
>>> must be 3!



