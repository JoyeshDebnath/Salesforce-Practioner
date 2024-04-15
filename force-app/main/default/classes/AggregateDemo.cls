public class AggregateDemo {
    public static void aggregateDemoFunc(){
        

for(AggregateResult result:[SELECT StageName,SUM(Amount) sumAmt,
                                AVG(Amount) avgAmt,MIN(Amount) minAmt,
                                MAX(Amount) maxAmt
                                FROM Opportunity 
                                GROUP BY StageName
                                HAVING 
                                SUM(Amount)>=30000]){
    System.debug('Stage Name : '+ result.get('StageName') +
       ' SUM of  Amount: '+result.get('sumAmt')+
 ' the Average : '+ result.get('avgAmt')+
 '  the min amount :'+result.get('minAmt')+
 '  the max amount :'+result.get('maxAmt'));
}
    }
}