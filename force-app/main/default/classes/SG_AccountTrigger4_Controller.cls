public  class SG_AccountTrigger4_Controller {
    public static void createRelatedContacts(List<Account> accountList){
            
        List<Contact> contactsList=new List<Contact>();
        for(Account acc:accountList){
                Contact contact=new Contact(
                    FirstName=acc.Name,
                    LastName=acc.Name,
                    AccountId=acc.Id
                    );

                    contactsList.add(contact);
            }
            if(!contactsList.isEmpty())
                        insert contactsList;
    }

    public static void createRelatedOpps(List<Account> accountList){
        List<Opportunity> oppList=new List<Opportunity>();

        for(Account acc:accountList){
            Opportunity opp=new Opportunity(
                Name=acc.Name,
                CloseDate=System.today()
            );

            oppList.add(opp);

        }
        insert oppList;
    }
}