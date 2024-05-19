/*
    Undelete Employee Record And Set Active Field To True 
 */
trigger SG_AfterUndelete on Employee__c (after undelete) {
    if(trigger.isAfter && trigger.isUndelete) {
        List<Employee__c> empList=new List<Employee__c>();

        Set<Id> accntIds=new Set<Id>();//account ids set 
        List<Account> accntListToBeUpdated=new List<Account>();
        if(!trigger.new.isEmpty()){
                for(Employee__c e:trigger.new){
                    Employee__c emp=new Employee__c();
                    emp.Id=e.Id;
                    emp.Active__c='true';
                    
                    
                    if(e.Account__c!=null){
                        emp.Account__c=e.Account__c;
                        accntIds.add(emp.Account__c);
                    }
                    empList.add(emp);
                }
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
            
        if(!empList.isEmpty()){
            update empList; 
        }
    }
}