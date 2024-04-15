trigger AccountTrigger_S1 on Account (before insert) {

    if(Trigger.isBefore && Trigger.isInsert)
             AccountTrigger_S1.onAfterInsert(Trigger.New);
}