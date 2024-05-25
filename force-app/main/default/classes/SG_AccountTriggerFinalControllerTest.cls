@isTest
public  class SG_AccountTriggerFinalControllerTest {
    
    @isTest public static void testCreateRelatedOppOrContacts(){
        List<Account> accList=new List<Account>();
        for(Integer i=1;i<=10;i++){
            Account acc=new Account();
            acc.Name='Test Account'+i;
            if(Math.mod(i,2)==0){
                acc.New_Contact__c=true;
            }
            else{
                acc.Active__c='Yes';
                acc.New_Opportunity__c=true;
            }
            accList.add(acc);
        }

        Test.startTest();
            insert accList;
        Test.stopTest();

        List<Contact> conList=[SELECT AccountId FROM Contact WHERE AccountId =: accList[1].Id];
        List<Opportunity> oppList=[SELECT AccountId FROM Opportunity WHERE AccountId =: accList[0].Id];

        System.assert(conList!=null);
        System.assert(oppList!=null);
    }
}