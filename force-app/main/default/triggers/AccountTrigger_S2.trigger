trigger AccountTrigger_S2 on Account (before insert) {

    if(Trigger.isBefore && Trigger.isInsert){
            AccountTrigger_S2_Handler.copyBillingtoShipping(Trigger.New);
    }
}