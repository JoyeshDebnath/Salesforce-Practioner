## Triggers ✍️

What is a Apex triggers :
It is a piece of code that executes before and after DML operation like Insert, Delete,Update Undelete etc . 
It enables us to perform custom Actions before or after changes to Salesforce records like Insertion , Deletion or Updation . 


- *Before Trigger*
 
  It executes Before the record gets saved to DB . It is used to update or validate record values before they saved to DB . 

  When to use : **Its is used when user wants to update the same record before saving . To validate the record before Saving .** 
 
  - *After Trigger*
  
  It executes after the record gets saved to DB . It is used to affect the changes in other records like updating a child record to access system generated fields like ID 

   When to use ? **Its is used when we need to access the fields values generated by the system such as id or LastModifiedByDate , and to affect changes in other records .** 



  ## Best practices in Triggers . 
  1. One trigger Per Object 
  2. Logic less triggers 
  3. Avoid calling Batch from Trigger 
  4. Avoid using DML and SOQL inside the for loop 
  5. Avoid hard coding IDs
   

### Syntax for Apex Trigger 

```java
    Trigger triggerName on ObjectName (TriggerEvents){
        //Write your trigger logic 
    }
```

### Context Variables 

- Context variables are used to access the records that caused the trigger to fire . 
- Context variables are implicit variables . All triggers in Salesforce determine implicit variables that enable the developers to access the runtime context . 
- These variables are contained in System.trigger class . 

1. isBefore : **Returns true if this trigger was fired before any record was saved**
2. isInsert: **Returns true if the trigger was fired due to an insert operation**
3. isUpdate: **Returns true if the trigger was fired due to an update operation**
4. new: **This sObject list is only available in insert,update, and undelete triggers, and the records can only be modified in before trigger**
5. isAfter: **returns true  if the trigger was fired after any record was saved**
6. old: **Returns a list of the old version of the sObject records.This sObject list is only avaialable in update and delete triggers**
7. oldMap: **Returns a map of the old versions of the sobject records. This sObject map is only avaialable in update and delete triggers**