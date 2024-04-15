/*
		Trigger handler 
		trigger : AccountTrigger_S1
*/

public class AccountTrigger_S1 {

    public static void onAfterInsert(List<Account> newList ){
       
        
        for(Account acc:newList){
            if(acc.Industry!=null){
                if(acc.Industry=='Media' || acc.Industry=='Energy'){
                 	acc.Rating='Hot';
                   
                }
            }
        }
        
    }
}