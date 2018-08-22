/**
 * Test class for trigger UserStoryTrigger_FAT.
 * <p /><p />
 * @author: Raymund Rodriguez
 */
@isTest(seeAllData = false)
public without sharing class UserStoryTriggerTest_FAT {
    
    /**
     * This method sets up the data for the test..
     */
    @testSetup 
    static void setup() {
        
        //Create common test data.
        Release_FAT__c objRelease = new Release_FAT__c();
        Sprint_FAT__c objSprint = new Sprint_FAT__c();
        ProgramIncrement_FAT__c objProgramIncrement = new ProgramIncrement_FAT__c();
        Project_FAT__c objProject = new Project_FAT__c();
        Epic_FAT__c objEpic = new Epic_FAT__c();
        Feature_FAT__c objFeature = new Feature_FAT__c();
        UserStory_FAT__c objUserStory = new UserStory_FAT__c();

        //Setting and inserting values.
        objProject.Name = 'Project Test Name';
        objProject.Description_FAT__c = 'Test Description';
        DMLOperationsClass_CF.insertRecord(objProject);
        objRelease.Description_FAT__c = 'Release Test';
        objRelease.Project_FAT__c = objProject.Id;
        DMLOperationsClass_CF.insertRecord(objRelease);
        objSprint.StartDate_FAT__c = System.today();
        objSprint.EndDate_FAT__c = System.today();
        objSprint.Release_FAT__c = objRelease.Id;
        objSprint.SprintName_FAT__c = 'Sprint 1';
        DMLOperationsClass_CF.insertRecord(objSprint);
        objProgramIncrement.Description_FAT__c = 'Program Increment Description';
        DMLOperationsClass_CF.insertRecord(objProgramIncrement);
        objEpic.Description_FAT__c = 'Epic Description';
        objEpic.Project_FAT__c = objProject.Id;
        DMLOperationsClass_CF.insertRecord(objEpic);
        objFeature.Description_FAT__c = 'Feature Description';
        objFeature.Epic_FAT__c = objEpic.Id;
        DMLOperationsClass_CF.insertRecord(objFeature);
        objUserStory.Title__c = 'US Title 1';
        objUserStory.Description_FAT__c = 'User Story Description';
        objUserStory.Status_FAT__c = 'Open';
        objUserStory.StoryPoints_FAT__c = 1;
        objUserStory.Feature_FAT__c = objFeature.Id;
        objUserStory.ProgramIncrement_FAT__c = objProgramIncrement.Id;
        objUserStory.Sprint_FAT__c = objSprint.Id;
        objUserStory.FunctionalOwner_FAT__c = UserInfo.getUserId();
        objUserStory.TechnicalOwner_FAT__c = UserInfo.getUserId();
        DMLOperationsClass_CF.insertRecord(objUserStory);
    }
    
    /**
     * This method tests the different status of a User Story, based on the Acceptance Criteria.
     */
    @isTest
    static void userStoryStatusUpdates() {
        Test.startTest();
        UserStory_FAT__c objUserStory = [SELECT Id FROM UserStory_FAT__c WHERE Title__c = 'US Title 1' LIMIT 1];
        objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_CLARIFICATION_REQUIRED;
        DMLOperationsClass_CF.updateRecord(objUserStory);
        objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_GROOMING;
        DMLOperationsClass_CF.updateRecord(objUserStory);
        objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_FOR_DEVELOPMENT;
        DMLOperationsClass_CF.updateRecord(objUserStory);
        objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_DEVELOPMENT_IN_PROGRESS;
        DMLOperationsClass_CF.updateRecord(objUserStory);
        objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_WAITING_FOR_DEPLOYMENT;
        DMLOperationsClass_CF.updateRecord(objUserStory);
        objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_NOT_REQUIRED;
        DMLOperationsClass_CF.updateRecord(objUserStory);
        objUserStory.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_COMPLETED;
        DMLOperationsClass_CF.updateRecord(objUserStory);
        Test.stopTest();
    }
}