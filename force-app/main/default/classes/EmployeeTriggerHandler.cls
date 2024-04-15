public class EmployeeTriggerHandler {

    public static void checkEmployeeStatus(List<Employee__c> employeeOldList){
        
        for(Employee__c emp:employeeOldList){
            if(emp.Active__c=='true')
                emp.addError('Active Employee Cant be Removed!');
        }
    }
    
    public static void updateLeftEmployeeCount(List<Employee__c> oldEmpList){
        List<Employee__c> employeeList=new List<Employee__c>();
        Map<Id,Account> idToAccountMap;
        Map<Id,Decimal> idToCountMap=new Map<Id,Decimal>();
        Set<Id> accountIds=new Set<Id>();
        List<Account> accountsToBeUpdated=new List<Account>();
        
        
        for(Employee__c emp:oldEmpList){
            if(emp.Account__c!=null){
                accountIds.add(emp.Account__c);
                employeeList.add(emp);
            }
        }//filter -->> setp 1 
        
        if(!accountIds.isEmpty()){
       			idToAccountMap=new Map<Id,Account>([SELECT Id,Left_Employee_Count__c FROM Account  WHERE Id IN : accountIds]);     
        }
        
        if(!employeeList.isEmpty()){
            for(Employee__c emp: employeeList){
                if(idToAccountMap.containsKey(emp.Account__c)){
                    if(idToCountMap.containsKey(emp.Account__c)){
                        //if it already has the id then update 
                        Decimal count=idToCountMap.get(emp.Account__c)+1;
                        idToCountMap.put(emp.Account__c,count);
                    }else{
                        //if not contains id 
                        idToCountMap.put(emp.Account__c,idToAccountMap.get(emp.Account__c).Left_Employee_Count__c+1);
                    }
                }
            }
        }
        
        for(Id accId:idToCountMap.keySet()){
            Account acc=new Account();
            acc.id=accId;
            acc.Left_Employee_Count__c=idToCountMap.get(accId);
            accountsToBeUpdated.add(acc);
        }
        
        if(!accountsToBeUpdated.isEmpty())
                update accountsToBeUpdated;
        
    }
    
    public static void undeleteEmployees(List<Employee__c> newList){
        List<Employee__c> employeeToBeUpdated=new List<Employee__c>();
        List<Employee__c> employeeList=new List<Employee__c>();
        Map<Id,Account> idToAccountMap;
        Set<Id> accountIds=new Set<Id>();
        Map<Id,Decimal> idToCountMap=new Map<Id,Decimal>();
        List<Account> accountsToBeUpdated=new List<Account>();
        
        
        for(Employee__c  emp: newList){
            Employee__c e=new Employee__c();
            e.id=emp.id;
            e.Active__c='true';
            employeeToBeUpdated.add(e);
            if(emp.Account__c!=null){
                accountIds.add(emp.Account__c);
                employeeList.add(emp);
            }
        }//filter
        
        if(!employeeList.isEmpty()){
               idToAccountMap=new Map<Id,Account>([SELECT Id,Left_Employee_Count__c FROM Account WHERE Id IN : accountIds]);
        }
        
        for(Employee__c e:employeeList){
            if(idToAccountMap.containsKey(e.Account__c)){
                if(idToCountMap.containsKey(e.Account__c)){
                    Decimal count=idToCountMap.get(e.Account__c)-1;
                        idToCountMap.put(e.Account__c,count);
                }
                else{
                    idToCountMap.put(e.Account__c,idToAccountMap.get(e.Account__c).Left_Employee_Count__c-1);
                }
            }
        }
        
         for(Id accId:idToCountMap.keySet()){
            Account acc=new Account();
            acc.id=accId;
            acc.Left_Employee_Count__c=idToCountMap.get(accId);
            accountsToBeUpdated.add(acc);
        }
        
         if(!accountsToBeUpdated.isEmpty())
                update accountsToBeUpdated;
        
        
        if(!employeeToBeUpdated.isEmpty())
                update employeeToBeUpdated;
    }
    

}