/**
 * Test class for trigger AcceptanceCriteriaTrigger_FAT.
 * <p /><p />
 * @author: Raymund Rodriguez
 */
@isTest(seeAllData = false)
public without sharing class AcceptanceCriteriaTriggerTest_FAT {
    
    /**
     * This method tests the continuation methods.
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
        AcceptanceCriteria_FAT__c objAcceptanceCriteria = new AcceptanceCriteria_FAT__c();

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
        DMLOperationsClass_CF.insertRecord(objUserStory);
        objUserStory = new UserStory_FAT__c();
        objUserStory.Title__c = 'US Title 2';
        objUserStory.Description_FAT__c = 'User Story Description';
        objUserStory.Status_FAT__c = 'Open';
        objUserStory.StoryPoints_FAT__c = 1;
        objUserStory.Feature_FAT__c = objFeature.Id;
        objUserStory.ProgramIncrement_FAT__c = objProgramIncrement.Id;
        objUserStory.Sprint_FAT__c = objSprint.Id;
        DMLOperationsClass_CF.insertRecord(objUserStory);
        objUserStory = new UserStory_FAT__c();
        objUserStory.Title__c = 'US Title 3';
        objUserStory.Description_FAT__c = 'User Story Description';
        objUserStory.Status_FAT__c = 'Open';
        objUserStory.StoryPoints_FAT__c = 1;
        objUserStory.Feature_FAT__c = objFeature.Id;
        objUserStory.ProgramIncrement_FAT__c = objProgramIncrement.Id;
        objUserStory.Sprint_FAT__c = objSprint.Id;
        DMLOperationsClass_CF.insertRecord(objUserStory);
    }
    
    /**
     * This method tests the different status of a User Story, based on the Acceptance Criteria.
     */
    @isTest
    static void userStoryStatusUpdates() {
        Test.startTest();
        UserStory_FAT__c objUserStory = [SELECT Id FROM UserStory_FAT__c WHERE Title__c = 'US Title 1' LIMIT 1];
        
        //First we test Clarification Required.
        AcceptanceCriteria_FAT__c objAcceptanceCriteria = new AcceptanceCriteria_FAT__c();
        objAcceptanceCriteria.UserStory_FAT__c = objUserStory.Id;
        objAcceptanceCriteria.Description_FAT__c = 'Test';
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_CLARIFICATION_REQUIRED;
        DMLOperationsClass_CF.insertRecord(objAcceptanceCriteria);
        System.assertEquals(StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_CLARIFICATION_REQUIRED, 
                [SELECT Status_FAT__c FROM UserStory_FAT__c WHERE Id = :objUserStory.Id].Status_FAT__c, 'User Story Status Update failed.');
        
        //Now we test Acceptance test.
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_ACCEPTANCE_TEST;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        System.assertEquals(StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_GROOMING, 
                [SELECT Status_FAT__c FROM UserStory_FAT__c WHERE Id = :objUserStory.Id].Status_FAT__c, 'User Story Status Update failed.');
                
        //Now we test Envisioning.
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_ENVISIONING;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        System.assertEquals(StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_GROOMING, 
                [SELECT Status_FAT__c FROM UserStory_FAT__c WHERE Id = :objUserStory.Id].Status_FAT__c, 'User Story Status Update failed.');
        
        //Now we test Approved.
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_APPROVED;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        System.assertEquals(StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_FOR_DEVELOPMENT, 
                [SELECT Status_FAT__c FROM UserStory_FAT__c WHERE Id = :objUserStory.Id].Status_FAT__c, 'User Story Status Update failed.');
        
        //Now we test Development In Progress.
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_IN_PROGRESS;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        System.assertEquals(StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_DEVELOPMENT_IN_PROGRESS, 
                [SELECT Status_FAT__c FROM UserStory_FAT__c WHERE Id = :objUserStory.Id].Status_FAT__c, 'User Story Status Update failed.');
        
        //Now we test Development Finished.
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_FINISHED;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        System.assertEquals(StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_WAITING_FOR_DEPLOYMENT, 
                [SELECT Status_FAT__c FROM UserStory_FAT__c WHERE Id = :objUserStory.Id].Status_FAT__c, 'User Story Status Update failed.');
                
        //Now we test Ready to be Tested.
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_READY_TO_BE_TESTED;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        System.assertEquals(StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_TO_BE_TESTED, 
                [SELECT Status_FAT__c FROM UserStory_FAT__c WHERE Id = :objUserStory.Id].Status_FAT__c, 'User Story Status Update failed.');
        
        //Now we test Development meets acceptance criteria.
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_CORRECT;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        System.assertEquals(StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_COMPLETED, 
                [SELECT Status_FAT__c FROM UserStory_FAT__c WHERE Id = :objUserStory.Id].Status_FAT__c, 'User Story Status Update failed.');
                
        //Now we test Not Required.
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_NOT_REQUIRED;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        System.assertEquals(StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_NOT_REQUIRED, 
                [SELECT Status_FAT__c FROM UserStory_FAT__c WHERE Id = :objUserStory.Id].Status_FAT__c, 'User Story Status Update failed.');
        Test.stopTest();
    }
    
    /**
     * This method tests the different status of a User Story, based on the Acceptance Criteria combinations.
     */
    @isTest
    static void userStoryStatusUpdatesCombinations() {
        Test.startTest();
        UserStory_FAT__c objUserStory = [SELECT Id FROM UserStory_FAT__c WHERE Title__c = 'US Title 1' LIMIT 1];
        AcceptanceCriteria_FAT__c objAcceptanceCriteria = new AcceptanceCriteria_FAT__c();
        
        //Now we test multiple acceptance criteria with Waiting for deployment result.
        objAcceptanceCriteria = new AcceptanceCriteria_FAT__c();
        objAcceptanceCriteria.UserStory_FAT__c = objUserStory.Id;
        objAcceptanceCriteria.Description_FAT__c = 'Test';
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_FINISHED;
        DMLOperationsClass_CF.insertRecord(objAcceptanceCriteria);
        objAcceptanceCriteria = new AcceptanceCriteria_FAT__c();
        objAcceptanceCriteria.UserStory_FAT__c = objUserStory.Id;
        objAcceptanceCriteria.Description_FAT__c = 'Test';
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_IN_PROGRESS;
        DMLOperationsClass_CF.insertRecord(objAcceptanceCriteria);
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_READY_TO_BE_TESTED;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_FINISHED;
        DMLOperationsClass_CF.updateRecord(objAcceptanceCriteria);
        
        //Now we test multiple acceptance criteria with Development in progress result.
        objUserStory = [SELECT Id FROM UserStory_FAT__c WHERE Title__c = 'US Title 2' LIMIT 1];
        objAcceptanceCriteria = new AcceptanceCriteria_FAT__c();
        objAcceptanceCriteria.UserStory_FAT__c = objUserStory.Id;
        objAcceptanceCriteria.Description_FAT__c = 'Test';
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_IN_PROGRESS;
        DMLOperationsClass_CF.insertRecord(objAcceptanceCriteria);
        objAcceptanceCriteria = new AcceptanceCriteria_FAT__c();
        objAcceptanceCriteria.UserStory_FAT__c = objUserStory.Id;
        objAcceptanceCriteria.Description_FAT__c = 'Test';
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_CORRECT;
        DMLOperationsClass_CF.insertRecord(objAcceptanceCriteria);
        
        //Now we generate another User Story, to test a different combination of Acceptance Criteria.
        objUserStory = [SELECT Id FROM UserStory_FAT__c WHERE Title__c = 'US Title 3' LIMIT 1];
        objAcceptanceCriteria = new AcceptanceCriteria_FAT__c();
        objAcceptanceCriteria.UserStory_FAT__c = objUserStory.Id;
        objAcceptanceCriteria.Description_FAT__c = 'Test';
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_CORRECT;
        DMLOperationsClass_CF.insertRecord(objAcceptanceCriteria);
        objAcceptanceCriteria = new AcceptanceCriteria_FAT__c();
        objAcceptanceCriteria.UserStory_FAT__c = objUserStory.Id;
        objAcceptanceCriteria.Description_FAT__c = 'Test';
        objAcceptanceCriteria.Status_FAT__c = StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_READY_TO_BE_TESTED;
        DMLOperationsClass_CF.insertRecord(objAcceptanceCriteria);
        Test.stopTest();
    }
}