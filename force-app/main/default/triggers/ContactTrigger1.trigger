trigger ContactTrigger1 on Contact (after insert) {
        if(Trigger.isAfter && Trigger.isInsert)  
               ContactTrigger1Handler.sendEmailNotification(Trigger.New);
   
}