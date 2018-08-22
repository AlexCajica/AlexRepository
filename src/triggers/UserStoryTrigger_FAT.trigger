/**
 * Trigger to control operations on User Story object.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
trigger UserStoryTrigger_FAT on UserStory_FAT__c(before insert, before update) {
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            UserStoryTriggerHelper_FAT.updateUserStoryOwner(Trigger.new, Trigger.oldMap);
        } else if(Trigger.isUpdate) {
            UserStoryTriggerHelper_FAT.updateUserStoryOwner(Trigger.new, Trigger.oldMap);
        }
    }
}