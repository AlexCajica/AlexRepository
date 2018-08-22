/**
 * This is a Helper class for AcceptanceCriteriaTrigger_FAT.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class AcceptanceCriteriaTriggerHelper_FAT {

    /**
     * This method updates the User Story status, based on the Acceptance Criteria status.
     *
     * @param lstAcceptanceCriterias    List of Acceptance Criteria records.
     * @param mapAcceptanceCriteriasOldValues   Map of old Acceptance Criteria records.
     */
    public static void updateUserStoryStatus(List<AcceptanceCriteria_FAT__c> lstAcceptanceCriterias, Map<Id, AcceptanceCriteria_FAT__c> mapAcceptanceCriteriasOldValues) {
        
        //We first get all the Parent Ids (User Stories)
        Set<Id> setAcceptanceCriteriaIds = new Set<Id>();
        Set<Id> setUserIds = new Set<Id>();
        for(AcceptanceCriteria_FAT__c objAcceptanceCriteria : lstAcceptanceCriterias) {
            if(mapAcceptanceCriteriasOldValues == null || 
                    mapAcceptanceCriteriasOldValues.get(objAcceptanceCriteria.Id).Status_FAT__c != objAcceptanceCriteria.Status_FAT__c) {
                setAcceptanceCriteriaIds.add(objAcceptanceCriteria.Id);
            }
        }
        for(AcceptanceCriteria_FAT__c objAcceptanceCriteria : [SELECT UserStory_FAT__c FROM AcceptanceCriteria_FAT__c WHERE Id IN :setAcceptanceCriteriaIds]) {
            setUserIds.add(objAcceptanceCriteria.UserStory_FAT__c);
        }
        List<AcceptanceCriteria_FAT__c> lstAllAcceptanceCriterias = [SELECT UserStory_FAT__r.Id, UserStory_FAT__r.Status_FAT__c, Status_FAT__c FROM AcceptanceCriteria_FAT__c WHERE 
                UserStory_FAT__c IN :setUserIds];
        
        //We get all the details of all the User Stories related to the Acceptance Criteria records.
        UserStoryDetailsWrapper objUserStoryDetails;
        List<UserStory_FAT__c> lstUserStories = new List<UserStory_FAT__c>();
        Map<Id, UserStoryDetailsWrapper> mapUserStoriesDetails = new Map<Id, UserStoryDetailsWrapper>();
        for(AcceptanceCriteria_FAT__c objAcceptanceCriteria : lstAllAcceptanceCriterias) {
            objUserStoryDetails = mapUserStoriesDetails.get(objAcceptanceCriteria.UserStory_FAT__c);
            if(objUserStoryDetails == null) {
                objUserStoryDetails = new UserStoryDetailsWrapper(objAcceptanceCriteria.UserStory_FAT__r);
            }
            if(objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_CLARIFICATION_REQUIRED) {
                objUserStoryDetails.boolHasClarificationRequired = true;
            } else if(objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_ACCEPTANCE_TEST || 
                    objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_ENVISIONING) {
                objUserStoryDetails.boolIsBeingGroomed = true;
            } else if(objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_APPROVED) {
                objUserStoryDetails.intNumberOfApproved++;
            } else if(objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_IN_PROGRESS) {
                objUserStoryDetails.intNumberOfDevelopmentInProgress++;
            } else if(objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_FINISHED) {
                objUserStoryDetails.intNumberOfDevelopmentFinished++;
            } else if(objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_CORRECT ||
                    objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_NOT_REQUIRED) {
                objUserStoryDetails.intNumberOfCompleted++;
                if(objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_NOT_REQUIRED) {
                    objUserStoryDetails.intNumberOfNotRequired++;
                }
            } else if(objAcceptanceCriteria.Status_FAT__c == StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_READY_TO_BE_TESTED) {
                objUserStoryDetails.intNumberOfReadyToBeTested++;
            }
            objUserStoryDetails.intTotalSize++;
            mapUserStoriesDetails.put(objAcceptanceCriteria.UserStory_FAT__c, objUserStoryDetails);
        }
        
        //Now we define the User Stories statuses.
        for(UserStoryDetailsWrapper objUserStoryDetailsFinal : mapUserStoriesDetails.values()) {
            if(objUserStoryDetailsFinal.boolHasClarificationRequired) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_CLARIFICATION_REQUIRED) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_CLARIFICATION_REQUIRED;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(objUserStoryDetailsFinal.boolIsBeingGroomed) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_GROOMING) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_GROOMING;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(objUserStoryDetailsFinal.intTotalSize == objUserStoryDetailsFinal.intNumberOfApproved) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_FOR_DEVELOPMENT) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_FOR_DEVELOPMENT;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(objUserStoryDetailsFinal.intTotalSize == objUserStoryDetailsFinal.intNumberOfDevelopmentInProgress) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_DEVELOPMENT_IN_PROGRESS) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_DEVELOPMENT_IN_PROGRESS;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(objUserStoryDetailsFinal.intTotalSize == objUserStoryDetailsFinal.intNumberOfDevelopmentFinished) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_WAITING_FOR_DEPLOYMENT) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_WAITING_FOR_DEPLOYMENT;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(objUserStoryDetailsFinal.intTotalSize == objUserStoryDetailsFinal.intNumberOfReadyToBeTested) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_TO_BE_TESTED) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_TO_BE_TESTED;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(objUserStoryDetailsFinal.intTotalSize == objUserStoryDetailsFinal.intNumberOfNotRequired) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_NOT_REQUIRED) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_NOT_REQUIRED;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(objUserStoryDetailsFinal.intTotalSize == objUserStoryDetailsFinal.intNumberOfCompleted) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_COMPLETED) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_COMPLETED;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(((objUserStoryDetailsFinal.intNumberOfCompleted + objUserStoryDetailsFinal.intNumberOfReadyToBeTested) == objUserStoryDetailsFinal.intTotalSize) && 
                    objUserStoryDetailsFinal.intNumberOfApproved == 0 && objUserStoryDetailsFinal.intNumberOfDevelopmentFinished == 0 && 
                    objUserStoryDetailsFinal.intNumberOfDevelopmentInProgress == 0) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_TO_BE_TESTED) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_TO_BE_TESTED;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(((objUserStoryDetailsFinal.intNumberOfDevelopmentFinished + objUserStoryDetailsFinal.intNumberOfCompleted + 
                    objUserStoryDetailsFinal.intNumberOfReadyToBeTested) == objUserStoryDetailsFinal.intTotalSize) && objUserStoryDetailsFinal.intNumberOfApproved == 0 && 
                    objUserStoryDetailsFinal.intNumberOfDevelopmentInProgress == 0) {
                if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_WAITING_FOR_DEPLOYMENT) {
                    objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_WAITING_FOR_DEPLOYMENT;
                    lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
                }
            } else if(objUserStoryDetailsFinal.objUserStory.Status_FAT__c != StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_DEVELOPMENT_IN_PROGRESS) {
                objUserStoryDetailsFinal.objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_DEVELOPMENT_IN_PROGRESS;
                lstUserStories.add(objUserStoryDetailsFinal.objUserStory);
            } 
        }
        
        //Finally, we update the status of the User Stories.
        if(lstUserStories.size() > 0) {
            StaticVariablesClass_FAT.BOOLEAN_ACCEPTANCE_CRITERIA_TRIGGER_IS_ACTIVE = false;
            DMLOperationsClass_CF.updateRecords(lstUserStories);
            StaticVariablesClass_FAT.BOOLEAN_ACCEPTANCE_CRITERIA_TRIGGER_IS_ACTIVE = true;
        }
    }
    
    /**
     * Inner class to store the User Story and Acceptance Criteria details.
     * <p /><p />
     * @author Raymundo Rodriguez
     */
    public class UserStoryDetailsWrapper {
        
        //Public variables.
        public Boolean boolHasClarificationRequired {get; set;}
        public Boolean boolIsBeingGroomed {get; set;}
        public Integer intNumberOfDevelopmentFinished {get; set;}
        public Integer intNumberOfDevelopmentInProgress {get; set;}
        public Integer intNumberOfApproved {get; set;}
        public Integer intNumberOfCompleted {get; set;}
        public Integer intNumberOfNotRequired {get; set;}
        public Integer intNumberOfReadyToBeTested {get; set;}
        public Integer intTotalSize {get; set;}
        public UserStory_FAT__c objUserStory {get; set;}
        
        /**
         * Constructor of the class.
         */
        public UserStoryDetailsWrapper(UserStory_FAT__c objUserStory) {
            boolHasClarificationRequired = false;
            boolIsBeingGroomed = false;
            intNumberOfDevelopmentFinished = 0;
            intNumberOfDevelopmentInProgress = 0;
            intNumberOfApproved = 0;
            intNumberOfCompleted = 0;
            intNumberOfNotRequired = 0;
            intNumberOfReadyToBeTested = 0;
            intTotalSize = 0;
            this.objUserStory = objUserStory;
        }
    }
}