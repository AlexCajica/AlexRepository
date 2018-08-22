/**
 * Trigger to control operations on Component.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
trigger ComponentTrigger_FAT on Component_FAT__c(after insert, after update) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            ComponentTriggerHelper_FAT.rejectDuplicatedRecords(Trigger.new);
        } else if(Trigger.isUpdate) {
            ComponentTriggerHelper_FAT.rejectDuplicatedRecords(Trigger.new);
        }
    }
}