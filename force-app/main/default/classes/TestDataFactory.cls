@isTest
public class TestDataFactory {
    public static List<Account> createAccountWithOpps(integer numOfAccts,integer numOfOppsPerAcct){

        List<Account> accts=new List<Account>();
        for(integer i=0;i<numOfAccts;i++){
            accts.add(new Account(Name='Test Accnt'+i));
        }
        insert accts;
        List<Opportunity> opps=new List<Opportunity>();
        for(integer i=0;i<numOfAccts;i++){
            Account acc=accts[i];
            for(integer j=0;j<numOfOppsPerAcct;j++){
                opps.add(new Opportunity(
                    Name=acc.Name + ' Opportunity ' + j,
                    StageName='Prospecting',
                    CloseDate=System.today(),
                    AccountId=acc.Id
                ));
            }
        }
        insert opps;

        return accts;
    }

}