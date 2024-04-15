trigger EmployeeTrigger on Employee__c (before delete, after delete,after undelete) {
    if(Trigger.isDelete){
        if(Trigger.isBefore){
            EmployeeTriggerHandler.checkEmployeeStatus(Trigger.Old);
        }
        if(Trigger.isAfter){
            EmployeeTriggerHandler.updateLeftEmployeeCount(Trigger.Old);
        }
    }
    if(Trigger.isUndelete && Trigger.isAfter){
           EmployeeTriggerHandler.undeleteEmployees(Trigger.New);
    }
}