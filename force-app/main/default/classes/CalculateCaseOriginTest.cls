@isTest
public class CalculateCaseOriginTest {
	@isTest
    private static void testCountCases(){
        List<Account> accList=new List<Account>();
        for(integer i=0;i<5;i++){
            Account acc=new Account(Name='Test Account'+i);
            accList.add(acc);
        }
        insert accList;
        
        List<Case> caseList=new List<Case>();
        List<Id> accIds=new List<Id>();
        
        for(Account acc:accList){
            accIds.add(acc.Id);
            for(integer i=1;i<=3;i++){
                Case c=new Case();
                c.AccountId=acc.Id;
                c.Status='New';
                c.Origin='Phone';
                caseList.add(c);
            }
            for(integer i=0;i<3;i++){
                Case c=new Case();
                c.AccountId=acc.Id;
                c.Status='New';
                c.Origin='Email';
                caseList.add(c);
            }
            for(integer i=0;i<3;i++){
                Case c=new Case();
                c.AccountId=acc.Id;
                c.Status='New';
                c.Origin='Web';
                caseList.add(c);
            }
        }
        insert caseList;
        Test.startTest();
        	CalculateCaseOrigin.countCasesBasedOnOrigin(accIds);
        Test.stopTest();
        
        List<Account> updatedAccs=[SELECT Id, Case_Through_Phone__c,
                                	Case_Through_Email__c,Case_Through_Web__c
                              		FROM Account WHERE Id IN : accIds];
        
        System.assertEquals(3,updatedAccs[0].Case_Through_Phone__c);
        
    }
}