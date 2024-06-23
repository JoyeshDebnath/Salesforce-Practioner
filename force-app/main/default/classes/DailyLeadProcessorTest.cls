@isTest
public class DailyLeadProcessorTest {

    @isTest
    public static void testUpdateLeadSource(){
        List<Lead> leadList=new List<Lead>();
        for(integer i=1;i<=200;i++){
            leadList.add(new Lead(
            	LastName='lead'+i,
                Status='Open - Not Contacted',
                Company='GE'
               ));
        }
        
        insert leadList;
        
        Test.startTest();
       
		System.schedule('Scheduled Job0'+System.now(), '0 0 * * * ?',  new DailyLeadProcessor ());
        Test.stopTest();
        
        System.assertEquals('Dreamforce',[SELECT Id,LeadSource FROM Lead WHERE LastName LIKE 'lead%'][0].LeadSource);
    }
}