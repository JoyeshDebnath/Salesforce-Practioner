global class RemindOppOwners implements Schedulable{
    global void execute(SchedulableContext context){
         
         List<Opportunity> oppList=[SELECT Id,Name,OwnerId,CloseDate
                                  	FROM Opportunity 
                                    WHERE IsClosed=False 
                                    AND 
                                    CloseDate<Today
                                  ];
        
        TaskUtils.remindOwners(oppList);
    }
}