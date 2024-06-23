/*
	Create a Future method to count how many cases are created threough phone , email  and web . 
	You need to put the counted values on Account in 3 diff fields . 
	Write test class to cover the code . 

*/


public class CalculateCaseOrigin {

    @future
    public static void countCasesBasedOnOrigin(List<Id> accIds){
        List<Account> accList= [SELECT Id, Case_Through_Phone__c,
                                Case_Through_Email__c,Case_Through_Web__c
                               ,(SELECT Id,Origin FROM Cases)
                                FROM Account WHERE Id IN : accIds];
       
        
        
        for(Account acc: accList){
        		Decimal webCount=0;
            	Decimal phoneCount=0;
        		Decimal emailCount=0;
            
            For (Case cs:acc.Cases){
                if(cs.Origin=='Web')
                    webCount++;
                else if(cs.Origin=='Phone'){
                    phoneCount++;
                }
                else{
                    emailCount++;
                }
                
            }
            
            acc.Case_Through_Phone__c=phoneCount;
            acc.Case_Through_Email__c=emailCount;
            acc.Case_Through_Web__c=webCount;
            
    	}
        
        if(!accList.isEmpty())
            update accList;
}
}