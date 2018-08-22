/**
 * Trigger to control operations on TestCaseStep_FAT__c.
 * <p /><p />
 * @author Alberto Gomez
 */
trigger TestCaseTrigger_FAT on TestCaseStep_FAT__c (after update, after insert) {
    if(Trigger.isUpdate) {
        if(Trigger.isAfter) {
            for(TestCaseStep_FAT__c objTestCaseStep : Trigger.new) {
                TestCaseTriggerHelper_FAT.updateTestCaseStatus(objTestCaseStep);
            }
        }
    }
    if(Trigger.isInsert) {
        if(Trigger.isAfter) {
            for(TestCaseStep_FAT__c objTestCaseStep : Trigger.new) {
                TestCaseTriggerHelper_FAT.updateTestCaseStatus(objTestCaseStep);
            }
        }
    }
}