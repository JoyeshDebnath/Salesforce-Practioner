public  class SG_AccountTriggerHandler {
    
    public static void updateRating(List<Account> accountList){
        for(Account acc:accountList){
            if(acc.Industry!=null && (acc.Industry=='Media' || acc.Industry=='Energy'))
            {
                acc.Rating = 'Hot';
            }
        }
    }
}