public  class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String searchKey){

        List<List<sObject>> sObjectList=[FIND :searchKey IN NAME FIELDS RETURNING Contact(FirstName,LastName WHERE (FirstName=:searchKey OR LastName=:searchKey)),Lead(FirstName,LastName WHERE (FirstName=:searchKey OR LastName=:searchKey)) ];

        return  sObjectList;
    }
}