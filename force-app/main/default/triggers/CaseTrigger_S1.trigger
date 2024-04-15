trigger CaseTrigger_S1 on Case (after insert) {

    if(Trigger.isAfter && Trigger.isInsert)
        CaseTrigger_S1_Handler.updateLatestCaseNumber(Trigger.New);
}