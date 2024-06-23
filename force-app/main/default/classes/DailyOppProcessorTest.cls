@isTest
public class DailyOppProcessorTest {
	
   static  String sch='0 0 0 18 6 ? 2024';
        
    @isTest 
    private static void testScheduledApex(){
        List<Opportunity> oppList=new List<Opportunity>();
        for(integer i=0;i<500;i++){
            if(i<250){
                oppList.add(new Opportunity(
                    Name='Test opp'+i,
                	StageName='Prospecting',
                    CloseDate=System.today()
                ));
            }
            else{
                oppList.add(new Opportunity(
                	Name='Test Opp'+i,
                    StageName='Prospecting',
                    CloseDate=System.today(),
                    LeadSource='Other'
                ));
            }
            
        }
        
        insert oppList;
        
        Test.startTest();
        String jobID=System.schedule('Process Opportunities',sch,new DailyOppProcessor());
        Test.stopTest();
        
        List<Opportunity> opps=[SELECT Id,LeadSource, Name 
                                FROM Opportunity 
                                WHERE LeadSource='web'];
        
        System.assertEquals(200,opps.size());
    }
}