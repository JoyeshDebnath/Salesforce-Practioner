/*
	test class for account trigger s1 handler 
*/
@isTest
public class AccountTriggger_S1_HandlerTest {
	
    @isTest
    public static void updateRatingTest(){
        //data creating 
        List<Account> accList=new List<Account>();
            for(Integer i=1;i<=5;i++){
                Account acc=new Account();
                acc.Name='Test'+' '+i;
                if(math.mod(i,2)==0){
                    acc.Industry='Energy';
                }else{
                     acc.Industry='Media';
                }
                accList.add(acc);
                
            }
            
            
        
        //insert  data 
            Test.startTest();
            insert accList;	
            Test.stopTest();
        
        List<Account> updatedAccntList=[SELECT Id,Rating,Industry FROM Account WHERE Id =:accList[0].Id];
        //assert conditions 
        System.assertEquals('Hot',updatedAccntList[0].Rating);
        
    }
}