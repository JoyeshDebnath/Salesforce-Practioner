trigger OppTrigger_S1 on Opportunity (before insert) {

    if(Trigger.isBefore && Trigger.isInsert)
            OppTrigger_S1_Handler.updateDescription(Trigger.New);
}