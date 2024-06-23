@isTest
public class OppProcessorTest {
	@isTest 
    private static void testBatchClass (){
        List<Opportunity> oppList = new List<Opportunity>();
        for(integer i=0;i<200;i++){
            Opportunity opp=new Opportunity(
            	Name='Test Opp'+i,
                StageName='Prospecting',
                CloseDate=System.today()
              );
            oppList.add(opp);
        }
        
        insert oppList;
        
        Test.startTest();
        OppProcessor oppprocess=new OppProcessor();
        Id batchId=Database.executeBatch(oppprocess,200);
        Test.stopTest();
        
        List<Opportunity> opps=[SELECT Id,LeadSource FROM Opportunity
                                WHERE LeadSource = 'web'];
        System.assertEquals(200,opps.size());
        
    }
}