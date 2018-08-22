/**
 * Trigger to control operations on Sprint.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
trigger SprintTrigger_FAT on Sprint_FAT__c(after insert, after update) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            SprintTriggerHelper_FAT.rejectDuplicatedRecords(Trigger.new);
        } else if(Trigger.isUpdate) {
            SprintTriggerHelper_FAT.rejectDuplicatedRecords(Trigger.new);
        }
    }
}