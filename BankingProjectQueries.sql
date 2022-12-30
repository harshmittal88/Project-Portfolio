CREATE DATABASE BANKING_DB

USE BANKING_DB

GO
CREATE SCHEMA BANK
GO
CREATE SCHEMA ACCOUNT
GO
CREATE SCHEMA TRANSACTIONS

CREATE TABLE BANK.tblBank
(
bankId BIGINT,
bankDetails VARCHAR(50)
) ON Bank_Customer_Details

ALTER TABLE BANK.tblBank ALTER COLUMN  bankId BIGINT NOT NULL 
ALTER TABLE BANK.tblBank ADD CONSTRAINT PK_bankId PRIMARY KEY  (bankId)

INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1000,'State Bank of India')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES  (1001,'State Bank of Mysore')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1002,'State Bank of Hyderbad')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1003,'ICICI')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1004,'Punjab Nationnal Bank')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1005,'HDFC')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1006,'IDBI')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1007,'Karnataka Bank')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1008,'Syndicate Bank')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1009,'Canara Bank')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1010,'Citi Bank')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1011,'Wells Fargo')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1012,'Discover')
INSERT INTO BANK.tblBank OUTPUT INSERTED.bankId, inserted.bankDetails VALUES (1013,'TCF')

CREATE TABLE tbladdAddress
(
addId	BIGINT IDENTITY (1000,1) PRIMARY KEY,
addLine1	VARCHAR(100),
addLine2	VARCHAR(50),
addCity	VARCHAR(50),
addPostCode	VARCHAR(15),
addState	VARCHAR(50),
addCountry	VARCHAR(50)
) ON Bank_Customer_Details


INSERT INTO BANK.tbladdAddress (addLine1,addLine2,addCity,addPostCode,addState,addCountry) VALUES('9730 37th Place North','Apt#204','Plymouth','55441','MN','USA')
INSERT INTO BANK.tbladdAddress (addLine1,addLine2,addCity,addPostCode,addState,addCountry) VALUES('Kombettu House','Padavu, Ujirpade Post Balnad','Puttur','574203','Karnataka','India')
INSERT INTO BANK.tbladdAddress (addLine1,addLine2,addCity,addPostCode,addState,addCountry) VALUES('302, Sai Manor Towers','X Roads, SR Nagar','Hyderabad','574038','Andra Pradesh','India')


DROP TABLE tbladdAddress

CREATE TABLE BANK.tbladdAddress
(
addId	BIGINT IDENTITY (1000,1) PRIMARY KEY,
addLine1	VARCHAR(100),
addLine2	VARCHAR(50),
addCity	VARCHAR(50),
addPostCode	VARCHAR(15),
addState	VARCHAR(50),
addCountry	VARCHAR(50)
) ON Bank_Customer_Details

INSERT INTO BANK.tbladdAddress (addLine1,addLine2,addCity,addPostCode,addState,addCountry) VALUES('9730 37th Place North','Apt#204','Plymouth','55441','MN','USA')
INSERT INTO BANK.tbladdAddress (addLine1,addLine2,addCity,addPostCode,addState,addCountry) VALUES('Kombettu House','Padavu, Ujirpade Post Balnad','Puttur','574203','Karnataka','India')
INSERT INTO BANK.tbladdAddress (addLine1,addLine2,addCity,addPostCode,addState,addCountry) VALUES('302, Sai Manor Towers','X Roads, SR Nagar','Hyderabad','574038','Andra Pradesh','India')

SELECT * FROM BANK.tbladdAddress

CREATE TABLE BANK.tblbtBranchType
(
btId	BIGINT IDENTITY (1000,1) PRIMARY KEY,
btTypeCode	VARCHAR(4),
btTypeDesc	VARCHAR(100)
)ON Bank_Customer_Details

INSERT INTO BANK.tblbtBranchType (btTypeCode,btTypeDesc) VALUES ('LU','Large Urban')
INSERT INTO BANK.tblbtBranchType (btTypeCode,btTypeDesc) VALUES ('SR','Small Rural')
INSERT INTO BANK.tblbtBranchType (btTypeCode,btTypeDesc) VALUES ('HO','Head Office')

EXEC sp_pkeys tblBank

CREATE TABLE BANK.tblbrBranch
(
brID	BIGINT IDENTITY (1000,1) PRIMARY KEY,
brAddress_fk BIGINT REFERENCES BANK.tbladdAddress(addId),  
brBankId_fk	BIGINT REFERENCES BANK.tblBank(bankId),
brBranchTypeCode_fk	BIGINT REFERENCES BANK.tblbtBranchType(btId),
brBranchName	VARCHAR(100),
brBranchPhone1	VARCHAR(20),
brBranchPhone2	VARCHAR(20),
brBranchFax	VARCHAR(20),
brBranchemail	VARCHAR(50),
brBranchIFSC	VARCHAR(20)
) ON Bank_Customer_Details

INSERT INTO Bank.tblbrBranch(brAddress_fk,brBankId_fk,brBranchTypeCode_fk,brBranchName,brBranchPhone1,brBranchPhone2,brBranchFax,brBranchemail,brBranchIFSC) VALUES (1000,1011,1001,'Golden Valley','1 323 416 4705','1 323 416 4095','1 763 954 1522','wellsfargogv@wellsfargo.com','WFGV1015')
INSERT INTO Bank.tblbrBranch(brAddress_fk,brBankId_fk,brBranchTypeCode_fk,brBranchName,brBranchPhone1,brBranchPhone2,brBranchFax,brBranchemail,brBranchIFSC) VALUES (1001,1007,1002,'Mangalore','91 824 247623','91 824 247624','91 824 247625','banker25@karnatakabank.com','KBIN05267')
INSERT INTO Bank.tblbrBranch(brAddress_fk,brBankId_fk,brBranchTypeCode_fk,brBranchName,brBranchPhone1,brBranchPhone2,brBranchFax,brBranchemail,brBranchIFSC) VALUES (1002,1000,1000,'Puttur Market','91 8251 249246','91 8251 249247','91 8251 249244','sbi.04270@sbi.co.in','SBIN004270')






CREATE TABLE BANK.tblcstCustomer
(	
	cstId	         BIGINT  IDENTITY (1000,1) primary key,
	cstAddId_fk	     BIGINT REFERENCES BANK.tbladdAddress(addId),
	cstBranchId_fk	 BIGINT REFERENCES [BANK].[tblbrBranch] (brId),
	cstFirstName	 VARCHAR(50),
	cstLastName	     VARCHAR(50),
	CstMiddleName	 VARCHAR(50),
	cstDOB	         DATE,
	cstSince	     DATETIME,
	cstPhone1	     VARCHAR(20),
	cstPhone2	     VARCHAR(20),
	cstFax	         VARCHAR(20),
	cstGender	     VARCHAR(10),
	cstemail	     VARCHAR(50)
)ON Bank_Customer_Details



INSERT INTO BANK.tblcstCustomer (cstAddId_fk,cstBranchId_fk,cstFirstName,cstLastName,CstMiddleName,cstDOB,cstSince,cstPhone1,cstPhone2,cstFax,cstGender,cstemail) VALUES (1001,1002,'Gaurao','Tarpe','','25-Dec-1986','2000','91 824 247623','','','Male','y')
INSERT INTO BANK.tblcstCustomer (cstAddId_fk,cstBranchId_fk,cstFirstName,cstLastName,CstMiddleName,cstDOB,cstSince,cstPhone1,cstPhone2,cstFax,cstGender,cstemail) VALUES (1002,1002,'Chaithra','Kunjathaya','Nithin','19-Jan-1990','2005','91 8251 249246','','','Female','y')
INSERT INTO BANK.tblcstCustomer (cstAddId_fk,cstBranchId_fk,cstFirstName,cstLastName,CstMiddleName,cstDOB,cstSince,cstPhone1,cstPhone2,cstFax,cstGender,cstemail) VALUES (1001,1001,'Adarsh','Hegde','','19-Jan-1990','2015','91 8251 249246','','','Male','y')
INSERT INTO BANK.tblcstCustomer (cstAddId_fk,cstBranchId_fk,cstFirstName,cstLastName,CstMiddleName,cstDOB,cstSince,cstPhone1,cstPhone2,cstFax,cstGender,cstemail) VALUES (1000,1002,'Nithin','Kumar','','9-Nov-1985','1996','1 323 416 4705','','','Male','y')
INSERT INTO BANK.tblcstCustomer (cstAddId_fk,cstBranchId_fk,cstFirstName,cstLastName,CstMiddleName,cstDOB,cstSince,cstPhone1,cstPhone2,cstFax,cstGender,cstemail) VALUES (1000,1002,'Nathan','Kamas','','10-Nov-1985','1996','1 323 416 4705','','','Male','y')




CREATE TABLE ACCOUNT.tblaccAccountType
( 
accTypeId BIGINT IDENTITY (1000,1) PRIMARY KEY,
accTypeCode VARCHAR(10),
accTypeDesc VARCHAR(100)
)ON Bank_Customer_Details 


INSERT INTO ACCOUNT.tblaccAccountType VALUES ('CHK','Checking')
INSERT INTO ACCOUNT.tblaccAccountType VALUES ('SAV','Saving')
INSERT INTO ACCOUNT.tblaccAccountType VALUES ('CUR','Current')
INSERT INTO ACCOUNT.tblaccAccountType VALUES ('LN','Loan')


CREATE TABLE ACCOUNT.tblaccAccountStatus
( 
accStatusId BIGINT IDENTITY (1000,1) PRIMARY KEY,
accStatusCode VARCHAR(10),
accStatusDesc VARCHAR(50)
)ON Bank_Customer_Details 


INSERT INTO ACCOUNT.tblaccAccountStatus VALUES ('A','Active')
INSERT INTO ACCOUNT.tblaccAccountStatus VALUES ('C','Closed')

CREATE TABLE ACCOUNT.tblaccAccount
( 
accNumber BIGINT IDENTITY (20000,1) PRIMARY KEY,
accStatusCode_fk BIGINT REFERENCES ACCOUNT.tblaccAccountStatus(accStatusId),
accTypeCode_fk BIGINT REFERENCES ACCOUNT.tblaccAccountType(accTypeId),
accCustomerId_fk BIGINT REFERENCES BANK.tblcstCustomer(cstId),
accBalance DECIMAL(26,4)
) ON Bank_Customer_Details 

INSERT INTO ACCOUNT.tblaccAccount  (accStatusCode_fk,accTypeCode_fk,accCustomerId_fk,accBalance) VALUES (1000,1001,1000,10000)
INSERT INTO ACCOUNT.tblaccAccount  (accStatusCode_fk,accTypeCode_fk,accCustomerId_fk,accBalance) VALUES (1001,1000,1001,200000.9897)
INSERT INTO ACCOUNT.tblaccAccount  (accStatusCode_fk,accTypeCode_fk,accCustomerId_fk,accBalance) VALUES (1001,1001,1002,30000.456)
INSERT INTO ACCOUNT.tblaccAccount  (accStatusCode_fk,accTypeCode_fk,accCustomerId_fk,accBalance) VALUES (1001,1002,1003,5000)
INSERT INTO ACCOUNT.tblaccAccount  (accStatusCode_fk,accTypeCode_fk,accCustomerId_fk,accBalance) VALUES (1001,1000,1004,500)


CREATE TABLE TRANSACTIONS.tbltranTransactionType
( 
tranCodeID BIGINT IDENTITY (1000,1) primary key,
tranTypeDesc VARCHAR(50)
) ON Bank_Customer_Details 


INSERT INTO TRANSACTIONS.tbltranTransactionType(tranTypeDesc) VALUES ('Deposit')
INSERT INTO TRANSACTIONS.tbltranTransactionType(tranTypeDesc) VALUES ('Withdrawal')



CREATE TABLE TRANSACTIONS.tbltranTransaction
( 
tranID BIGINT IDENTITY (1000,1) PRIMARY KEY,
tranCode VARCHAR(50),
tranAccountNumber_fk BIGINT REFERENCES ACCOUNT.tblaccAccount (accNumber),
tranCode_fk BIGINT REFERENCES TRANSACTIONS.tbltranTransactionType(tranCodeID),
tranDatetime DateTime,
tranTransactionAmount Decimal(26,4),
tranMerchant VARCHAR(50),
tranDescription VARCHAR(50),
RunningBalance DECIMAL(26,4) DEFAULT NULL
) ON Bank_Customer_Details 


INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20000,1000,20500.456,'Self','Self Deposit')
INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20001,1001,200000,'Discover','Withdrawal')
INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20000,1001,13.45,'','Cheque #5001')
INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20001,1000,2500,'Self','Self Deposit')
INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20001,1000,25000,'Discover','Withdrawal')
INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20001,1001,200000,'Discover','Withdrawal')
INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20003,1000,20500.456,'Self','Self Deposit')
INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20004,1001,200000,'Discover','Withdrawal')
INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20001,1000,20500.456,'Self','Self Deposit')
INSERT INTO TRANSACTIONS.tbltranTransaction (tranAccountNumber_fk,tranCode_fk,tranTransactionAmount,tranMerchant,tranDescription) VALUES (20003,1001,25000,'Discover','Withdrawal')


CREATE SYNONYM synBank                  FOR BANK.tblBank
CREATE SYNONYM synAddress				FOR BANK.tbladdAddress
CREATE SYNONYM synBranchType			FOR BANK.tblbtBranchType
CREATE SYNONYM synBranch				FOR BANK.tblbrBranch
CREATE SYNONYM synCustomer				FOR BANK.tblcstCustomer
CREATE SYNONYM synAccountType			FOR ACCOUNT.tblaccAccountType
CREATE SYNONYM synAccountStatus			FOR ACCOUNT.tblaccAccountStatus
CREATE SYNONYM synAccount				FOR ACCOUNT.tblaccAccount
CREATE SYNONYM synTransactionType		FOR TRANSACTIONS.tbltranTransactionType  
CREATE SYNONYM synTransaction			FOR TRANSACTIONS.tbltranTransaction




--1. List total number of Customers for each Branch
SELECT synBranch.brID, COUNT(synCustomer.cstId) AS TOTAL_CUSTOMERS FROM synBranch
JOIN synCustomer
ON
synBranch.brID = synCustomer.cstBranchId_fk
GROUP BY (synBranch.brID)

SELECT * FROM synBranch
select * from synCustomer

-- 2. List all Banks and their Branches with total number of Accounts in each Branch

SELECT synBank.bankDetails,synBranch.brBranchName, COUNT(synAccount.accNumber) FROM synBank
JOIN synBranch
ON synBank.bankId=synBranch.brBankId_fk
JOIN synCustomer
ON synBranch.brID = synCustomer.cstBranchId_fk
JOIN synAccount 
ON synAccount.accCustomerId_fk=synCustomer.cstId
GROUP BY synBank.bankDetails,synBranch.brBranchName


-- 3. Find all Customer Accounts that does not have any Transaction
SELECT synCustomer.cstFirstName + ' ' + synCustomer.cstLastName AS CUST_NAME,synAccount.accNumber,synAccount.accBalance  FROM synAccount 
LEFT OUTER JOIN 
synTransaction
ON synAccount.accNumber=synTransaction.tranAccountNumber_fk
JOIN
synCustomer
ON synCustomer.cstId=synAccount.accCustomerId_fk
WHERE synTransaction.tranID IS NULL


-- 4. Rank the Customers for each Bank & Branch based on number of Transactions. 
--   Customer with maximum number of Transaction gets 1 Rank (Position)

SELECT C.cstFirstName , B.bankDetails, BR.brBranchName, COUNT(T.tranID) AS [NO. OF TRANSACTIONS],DENSE_RANK() OVER (ORDER BY COUNT(T.tranID) DESC) FROM synBank B
JOIN synBranch BR
ON B.bankId=BR.brBankId_fk
JOIN synCustomer C 
ON BR.brID = C.cstBranchId_fk
JOIN synAccount A 
ON C.cstId=A.accCustomerId_fk
JOIN synTransaction T
ON T.tranAccountNumber_fk = A.accNumber
GROUP BY C.cstFirstName , B.bankDetails, BR.brBranchName
--ORDER BY COUNT(T.tranID) DESC 


-- 5. LIST OF ALL ZIP CODES WITH MISSING CUSTOMER ADDRESS
SELECT AD.addPostCode FROM synAddress AD
LEFT OUTER JOIN synCustomer C 
ON AD.addId = C.cstAddId_fk 
WHERE C.cstId IS NULL


-- 6. LIST OF ALL CUSTOMERS WITH ACCOUNTS BASED ON ACCOUNT STATUS & TYPES WITHOUT ANY TRANSACTIONS
SELECT * FROM synCustomer C 
JOIN synAccount A
ON C.cstId = A.accCustomerId_fk 
LEFT OUTER JOIN synTransaction T 
ON A.accNumber = T.tranAccountNumber_fk
JOIN synAccountStatus ACCSTATUS
ON A.accStatusCode_fk = ACCSTATUS.accStatusId 
JOIN synAccountType ACCTYPE
ON ACCTYPE.accTypeId = A.accTypeCode_fk
WHERE T.tranID IS NULL

-- 7. LIST OF ALL BANKS BASED ON CUSTOMERS AND TRANSACTION AMOUNTS

SELECT B.bankDetails,C.cstFirstName,T.tranTransactionAmount,T.tranDescription FROM synBank B
LEFT OUTER JOIN synBranch BR
ON B.bankId	= BR.brBankId_fk 
LEFT OUTER JOIN synCustomer C 
ON C.cstBranchId_fk = BR.brID 
LEFT OUTER JOIN synAccount A 
ON A.accCustomerId_fk = C.cstId 
LEFT OUTER JOIN synTransaction T
ON T.tranAccountNumber_fk=A.accNumber
WHERE C.cstId IS NOT NULL

SELECT B.bankDetails,C.cstFirstName,T.tranTransactionAmount,T.tranDescription FROM synTransaction T
RIGHT OUTER JOIN synAccount A
ON T.tranAccountNumber_fk=A.accNumber
RIGHT OUTER JOIN synCustomer C
ON A.accCustomerId_fk = C.cstId
RIGHT OUTER JOIN synBranch BR
ON C.cstBranchId_fk = BR.brID
RIGHT OUTER JOIN synBank B
ON B.bankId	= BR.brBankId_fk  
WHERE C.cstId IS NOT NULL