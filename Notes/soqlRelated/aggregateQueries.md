

```sql
    SELECT COUNT(Id) numOfContacts,
     AccountId,Account.Name,
     MIN(CreatedDate) earliestCreatedDate,
     MAX(CreatedDate) mostRecentCreatedDate
     FROM Contact
     GROUP BY AccountId,Account.Name
     LIMIT 10
```

2. Get the number of accounts owned by each sales rep 

```sql
SELECT COUNT(Id) numberOfAccounts , 
         OwnerId ,
        Owner.Name 
        FROM Account 
        GROUP BY OwnerId,Owner.Name
```

3. See how many opportunities each rep has won and the average amount
```sql
    SELECT COUNT(Id) numOfOppWon ,
      OwnerId,
      Owner.Name,
      AVG(Amount) averageAmount
      FROM Opportunity
        WHERE StageName='Closed Won'
       GROUP BY OwnerId,Owner.Name
```

4.  Find the average amount of opportunities present in the GenePoint Account.
 ```sql
SELECT  AVG(Amount) averageAmountOfOpportunity 
		FROM Opportunity 
		WHERE Account.Name='Nippon TV'
 ```

5. find the total number of opportunities present in the GenePoint Account
```sql
SELECT COUNT(Id) CountOfOpportunities 
		FROM Opportunity 
		WHERE Account.Name='Nippon TV'
```
6. 
```sql

```