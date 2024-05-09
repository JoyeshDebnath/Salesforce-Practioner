public class AccountHandler {
    public static Account insertNewAccount(String accountName){
        try{
            
        Account accnt = new Account(Name=accountName);
        insert accnt;
        return accnt;
        }
        catch(DmlException e){
            System.debug('DML Exception : '+e.getMessage());
            return null;
        }
    }
}