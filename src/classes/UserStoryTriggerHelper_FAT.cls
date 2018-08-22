/**
 * This is a Helper class for UserStoryTrigger_FAT.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class UserStoryTriggerHelper_FAT {

    /**
     * This method updates the User Story owner based on the status.
     *
     * @param lstUserStories    List of User Story records.
     * @param mapOldUserStories    Map of old User Story records.
     */
    public static void updateUserStoryOwner(List<UserStory_FAT__c> lstUserStories, Map<Id, UserStory_FAT__c> mapOldUserStories) {
        for(UserStory_FAT__c objUserStory : lstUserStories) {
            if(mapOldUserStories == null || mapOldUserStories.get(objUserStory.Id).Status_FAT__c != objUserStory.Status_FAT__c) {
                if(objUserStory.FunctionalOwner_FAT__c != null && (
                        objUserStory.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_OPEN || 
                        objUserStory.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_GROOMING || 
                        objUserStory.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_CLARIFICATION_REQUIRED || 
                        objUserStory.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_TO_BE_TESTED || 
                        objUserStory.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_NOT_REQUIRED || 
                        objUserStory.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_COMPLETED)) {
                    objUserStory.OwnerId = objUserStory.FunctionalOwner_FAT__c;
                } else if(objUserStory.TechnicalOwner_FAT__c != null && (
                        objUserStory.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_FOR_DEVELOPMENT || 
                        objUserStory.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_WAITING_FOR_DEPLOYMENT || 
                        objUserStory.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_DEVELOPMENT_IN_PROGRESS)) {
                    objUserStory.OwnerId = objUserStory.TechnicalOwner_FAT__c;
                }
            }
        }
    }
}