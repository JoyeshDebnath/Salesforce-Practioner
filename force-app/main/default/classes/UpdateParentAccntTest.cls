@isTest
public class UpdateParentAccntTest {
	@testSetup
    public static  void setup(){
        List<Account> accList=new List<Account>();
        accList.add(new Account(Name='ParentAccnt'));
        for(integer i=0;i<100;i++){
            accList.add(new Account(Name='testAccnt'+i));
        }
        insert accList;
    } 
    
    @isTest
    private static void testQueueable(){
        Id parentId=[SELECT Id FROM Account WHERE Name='ParentAccnt'][0].Id;
        List<Account> accList=[SELECT Id,Name,ParentId FROM Account 
                               WHERE Name LIKE 'testAccnt%' ];
        
        UpdateParentAccnt updateJob=new UpdateParentAccnt(accList,parentId);
                Test.startTest();
                System.enqueueJob(updateJob);
                Test.stopTest();
        
        System.assertEquals(100,[SELECT count() FROM Account WHERE parentId=:parentId]);
    } 
}