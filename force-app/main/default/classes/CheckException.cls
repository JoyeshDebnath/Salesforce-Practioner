public class CheckException extends Exception {
    public  void testExceptions(){
        List<Opportunity> oppList=new List<Opportunity>();
        oppList.add(new Opportunity (
        Name='test Opportunity',
        
        StageName='Prospecting'
        ));
        List<Databse.SaveResult> saveresult=Databse.insert(oppList,false);
        for(Database.SaveResult res:saveresult){
            if(!res.isSuccess){
            System_Event__c event=new System_Event__c();
            event.Complete_Trace_String__c=dmlException.getStackTraceString();
            event.Exception_Type__c=dmlException.getTypeName();
            event.Component_Type__c='Apex Class';
            event.Component_Name__c='CheckException Class';
            event.Message__c=dmlException.getMessage();
            event.Line_Number__c=String.valueOf(dmlException.getLineNumber());
            event.User__c=UserInfo.getUserId();
            insert event;
            }else{

            }
        }
        // try{
        //     insert oppList;
        // }
        // catch(System.DmlException dmlException){
        //     System.debug('DML Exception block executed !');
        //     System.debug('Line number ='+dmlException.getLineNumber());
        //     System.debug('Complete trace string ='+dmlException.getStackTraceString());
        //     System.debug('Message ='+dmlException.getMessage());
        //     //trace the exception .... 
        //     System_Event__c event=new System_Event__c();
        //     event.Complete_Trace_String__c=dmlException.getStackTraceString();
        //     event.Exception_Type__c=dmlException.getTypeName();
        //     event.Component_Type__c='Apex Class';
        //     event.Component_Name__c='CheckException Class';
        //     event.Message__c=dmlException.getMessage();
        //     event.Line_Number__c=String.valueOf(dmlException.getLineNumber());
        //     event.User__c=UserInfo.getUserId();
        //     insert event;
            
        // }
    }
}