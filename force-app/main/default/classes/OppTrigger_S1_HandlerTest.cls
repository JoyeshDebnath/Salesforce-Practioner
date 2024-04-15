@isTest
public class OppTrigger_S1_HandlerTest {

    @isTest
    public static void testOppDescription(){
        //create 
        List<Opportunity> oppList=new List<Opportunity>();
        Integer counter=80000;
        for(Integer i=1;i<=5;i++){
            Opportunity opp=new Opportunity();
            opp.CloseDate=Date.today();
            opp.Name='Test Opportunity'+' '+i;
            opp.StageName='Prospecting';
            opp.Amount=counter;
            
            counter*=2;
            oppList.add(opp);
            
        }
        //insert
        Test.startTest();
        insert oppList;
        Test.stopTest();
        
        List<Opportunity> opp1 = [SELECT Id, Description FROM Opportunity WHERE Id =: oppList[0].Id ];
        List<Opportunity> opp2 = [SELECT Id, Description FROM Opportunity WHERE Id =: oppList[1].Id];
        System.assertEquals(null, opp1[0].Description);
        System.assertEquals('Hot Opportunity',opp2[0].Description);
        
    }
}