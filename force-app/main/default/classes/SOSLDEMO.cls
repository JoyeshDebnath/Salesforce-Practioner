public class SOSLDEMO {
    public static void getSoslResult(){
        List<List<sObject>> sObjectList=[FIND '"Joyesh" OR "SFDC"' IN ALL FIELDS 
                                        RETURNING Account(Id,Name,Phone),Contact(FirstName,LastName,Id) ];
        System.debug('sobjectlist: \n'+sObjectList);
    }

    public static void getSoslResultDemo2(){
        String searchClause='"Nippo*" OR "Toyota"';
        List<List<sObject>> sObjectList=[FIND :searchClause IN ALL FIELDS RETURNING Account(Id,Name,Phone),Contact(Id,FirstName,LastName,Email,Department)];

        Account[] searchAccounts=(Account[])sObjectList[0];
        Contact[] searchContacts=(Contact[])sObjectList[1];

        System.debug('The Following are the accounts found :');

        for(Account acc: searchAccounts){
            System.debug('Account name :'+acc.Name+'  Account Phone: '+acc.Phone);
        }

        System.debug('The following are the contacts found :');
        for(Contact con:searchContacts){
            System.debug('Contact name :'+con.FirstName+'  '+con.LastName+'  Contact Department='+con.Department);
            
        }
    }
    
}