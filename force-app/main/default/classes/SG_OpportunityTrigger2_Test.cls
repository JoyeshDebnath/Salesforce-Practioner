@isTest
public  class SG_OpportunityTrigger2_Test {
        @isTest public static void testOnBeforeInsert(){
            Opportunity opp=new Opportunity();
            opp.StageName='onBeforeInsert';
            opp.Amount=340000;
            opp.CloseDate=System.today();
            opp.Name='Test Opp';

            Test.startTest();
            insert opp;
            Test.stopTest();
            
            ID oppId=opp.Id;
            List<Opportunity> ops=[SELECT Id,Description FROM Opportunity WHERE Id=:oppId];

            System.assertEquals('Hot Opportunity', ops[0].Description);
        }    
}