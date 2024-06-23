@isTest
public class LeadProcessorTest {
	@testSetup
    public static void setupTestData(){
        
        List<Lead> leadList=new List<Lead>();
        
        for (integer i=1;i<=200;i++){
            Lead lead=new Lead(
            	LastName='TestLead'+i,
                Company='GE',
                Status='Open - Not Contacted',
                LeadSource='Other'
            );
            leadList.add(lead);
        }
        
        insert leadList;
    }
    
    @isTest
    public static void testLeadBatch(){
        Test.startTest();
        	LeadProcessor leadprocessor=new LeadProcessor();
			Id batchId=Database.executeBatch(leadprocessor);
        Test.stopTest();
        
        System.assertEquals('Dreamforce',[SELECT Id,LeadSource FROM Lead][0].LeadSource);
        
    }
}