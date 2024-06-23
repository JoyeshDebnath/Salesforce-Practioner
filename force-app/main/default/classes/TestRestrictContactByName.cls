@isTest 
public  class TestRestrictContactByName {
    @isTest 
    public static void testRestrictConName(){
        Contact con1=new Contact(
            FirstName='test contact',
            LastName='INVALIDNAME'
        );
        

        Test.startTest();
        Database.SaveResult result=Database.insert(con1,false);
        Test.stopTest();


        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size()>0);
        System.assertEquals('The Last Name "'+con1.LastName+'" is not allowed for DML', result.getErrors()[0].getMessage());
    }
}