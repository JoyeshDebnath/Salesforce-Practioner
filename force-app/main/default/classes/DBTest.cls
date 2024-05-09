public class DBTest {
    public static void test1(){
        Account accnt=new Account(Name='Lacme', Phone='(415)555-1212' , NumberOfEmployees=100);
        insert accnt;
        
        Id accntID=accnt.Id;
        System.debug('ID = '+accntID);
    }
}