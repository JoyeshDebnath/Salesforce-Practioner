@isTest
public  class SG_OpportunityTriggerFinalTest {
    
    @isTest public static void testUpdateDescriptionBasedOnStage_insert(){

        Opportunity opp1=new Opportunity();
        opp1.Name='test opp1';
        opp1.StageName='Closed Won';
        opp1.CloseDate=System.today();

        Opportunity opp2=new Opportunity();
        opp2.Name='test opp2';
        opp2.StageName='Closed Lost';
        opp2.CloseDate=System.today();

        Opportunity opp3=new Opportunity();
        opp3.Name='test opp3';
        opp3.StageName='Prospecting';
        opp3.CloseDate=System.today();

        Test.startTest();
        insert opp1;
        insert opp2;
        insert opp3;
        Test.stopTest();

        ID oppId=opp1.Id;
        List<Opportunity> oppList=[SELECT Id,Description FROM Opportunity WHERE Id=:opp1.Id];

        System.assert(oppList[0].Description!=null);
    } 
    
    
     @isTest public static void testUpdateDescriptionBasedOnStage_update(){

        Opportunity opp1=new Opportunity();
        opp1.Name='test opp1';
        opp1.StageName='Closed Won';
        opp1.CloseDate=System.today();

        Opportunity opp2=new Opportunity();
        opp2.Name='test opp2';
        opp2.StageName='Closed Lost';
        opp2.CloseDate=System.today();

        Opportunity opp3=new Opportunity();
        opp3.Name='test opp3';
        opp3.StageName='Prospecting';
        opp3.CloseDate=System.today();

        Test.startTest();
        insert opp1;
        insert opp2;
        insert opp3;
        opp1.StageName='Closed Lost';
        update opp1;
         
        Test.stopTest();

        ID oppId=opp1.Id;
        List<Opportunity> oppList=[SELECT Id,Description FROM Opportunity WHERE Id=:opp1.Id];

        System.assertEquals('Opportunity is Closed Lost',oppList[0].Description,oppList[0].Description);
    } 
}