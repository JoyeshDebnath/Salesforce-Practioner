public class ContactSearch {
    public static List<Contact> searchForContacts(String firstStr,String secondStr){

        List<Contact> conList=[SELECT Id,Name,FirstName,LastName,Phone FROM Contact WHERE (LastName=:firstStr AND MailingPostalCode=:secondStr)];

        return conList;

    }
}