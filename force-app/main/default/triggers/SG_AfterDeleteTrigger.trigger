/*
    Case 1 : Employee Record Cannot be deleted  if active is true 

    Case 2: When  Employee Record Deleted then update The Left Empoloyee Count on Account 

    Stack overflow for Query :
    
    https://salesforce.stackexchange.com/questions/230524/soql-query-to-display-number-of-opportunities-number-of-contacts-from-account
*/


trigger SG_AfterDeleteTrigger on Employee__c (before delete,after delete ) {
    //case 1 : 
    if(trigger.isBefore && trigger.isDelete) {
        if(!trigger.old.isEmpty()){
            for(Employee__c emp:trigger.old){
                if(emp.Active__c=='true'){
                    emp.addError('Employee Record Cannot be deleted As its still active !');
                }
        }
        }
    }

    //case 2: 
    
    Set<Id> accntIds=new Set<Id>();//account ids set 
    List<Account> accntListToBeUpdated=new List<Account>();
    if(trigger.isAfter && trigger.isDelete){
        if(!trigger.old.isEmpty()){
                for(Employee__c emp : trigger.old){
                    accntIds.add(emp.Account__c);
                }

                List<Account> accountList=[SELECT Id,Name,Left_Employee_Count__c , (SELECT Id ,Name FROM Employees__r) FROM Account WHERE Id IN : accntIds];//fetch the accounts whose related employees has been affected 

                    System.debug('data fetched : '+accountList);
                for(Account acc:accountList){
                    // acc.Left_Employee_Count__c
                    Decimal numOfEmployeesLeft=acc.Employees__r.size();
                    System.debug('size:'+acc.Employees__r.size());
                    System.debug('Number Of employees left:'+numOfEmployeesLeft);
                    acc.Left_Employee_Count__c=numOfEmployeesLeft;
                    System.debug('updated value :'+acc.Left_Employee_Count__c);
                    accntListToBeUpdated.add(acc);
                }
            //update
            if(!accntListToBeUpdated.isEmpty()){
                update accntListToBeUpdated;
            }
        }
    }

}