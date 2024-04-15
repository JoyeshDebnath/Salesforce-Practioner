trigger AccountTrigger_S3 on Account (after insert) {

    if(Trigger.isAfter && Trigger.isInsert)
            AccountTrigger_S3_Handler.createContact(Trigger.New);
}