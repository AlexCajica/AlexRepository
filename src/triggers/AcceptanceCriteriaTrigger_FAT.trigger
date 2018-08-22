/**
 * Trigger to control operations on Acceptance Criteria object.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
trigger AcceptanceCriteriaTrigger_FAT on AcceptanceCriteria_FAT__c(after insert, after update) {
    if(StaticVariablesClass_FAT.BOOLEAN_ACCEPTANCE_CRITERIA_TRIGGER_IS_ACTIVE) {
        if(Trigger.isAfter) {
            if(Trigger.isInsert) {
                AcceptanceCriteriaTriggerHelper_FAT.updateUserStoryStatus(Trigger.new, Trigger.oldMap);
            } else if(Trigger.isUpdate) {
                AcceptanceCriteriaTriggerHelper_FAT.updateUserStoryStatus(Trigger.new, Trigger.oldMap);
            }
        }
    }
}