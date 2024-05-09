public class ContactSearch {
    public static List<Contact> searchForContacts(String reqLastName,String reqMailAddress){
        Contact[] contacts=[SELECT Id,FirstName,LastName,MailingPostalCode FROM Contact WHERE (LastName=:reqLastName AND MailingPostalCode=:reqMailAddress) ];
        System.debug(contacts);
        return contacts;
    }
}