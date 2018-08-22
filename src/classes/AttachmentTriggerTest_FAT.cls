/**
 * Test class for trigger AttachmentTrigger_FAT.
 * <p /><p />
 * @author: Raymundo Rodriguez
 */
@isTest(seeAllData = false)
public without sharing class AttachmentTriggerTest_FAT {
    
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
        objUserStory.Title__c = 'US Title';
        objUserStory.Description_FAT__c = 'User Story Description';
        objUserStory.Status_FAT__c = 'Open';
        objUserStory.StoryPoints_FAT__c = 1;
        objUserStory.Feature_FAT__c = objFeature.Id;
        objUserStory.ProgramIncrement_FAT__c = objProgramIncrement.Id;
        objUserStory.Sprint_FAT__c = objSprint.Id;
        DMLOperationsClass_CF.insertRecord(objUserStory);
        objAcceptanceCriteria.UserStory_FAT__c = objUserStory.Id;
        objAcceptanceCriteria.Description_FAT__c = 'Test';
        objAcceptanceCriteria.Status_FAT__c = 'Envisioning';
        DMLOperationsClass_CF.insertRecord(objAcceptanceCriteria);
    }
    
    /**
     * This method tests the insertion of an Attachment on a User Story.
     */
    @isTest
    static void insertAttachmentOnUserStory() {
        Test.startTest();
        UserStory_FAT__c objUserStory = [SELECT Id FROM UserStory_FAT__c LIMIT 1];
        Blob objBodyBlob = Blob.valueOf('Unit Test Attachment Body');
        Attachment objAttachment = new Attachment();
        objAttachment.Name='Unit Test Attachment';
        objAttachment.Body = objBodyBlob;
        objAttachment.ParentId = objUserStory.Id;
        DMLOperationsClass_CF.insertRecord(objAttachment);
        Test.stopTest();
        System.assertEquals([SELECT Id FROM Attachment WHERE Parent.id = :objUserStory.Id].size(), 1, 'Attachment process failed.');
    }
    
    /**
     * This method tests the insertion of an Attachment on an Acceptance Criteria.
     */
    @isTest
    static void insertAttachmentOnAcceptanceCriteria() {
        Test.startTest();
        AcceptanceCriteria_FAT__c objAcceptanceCriteria = [SELECT Id FROM AcceptanceCriteria_FAT__c LIMIT 1];
        Blob objBodyBlob = Blob.valueOf('Unit Test Attachment Body');
        Attachment objAttachment = new Attachment();
        objAttachment.Name='Unit Test Attachment';
        objAttachment.Body = objBodyBlob;
        objAttachment.ParentId = objAcceptanceCriteria.Id;
        DMLOperationsClass_CF.insertRecord(objAttachment);
        Test.stopTest();
        System.assertEquals([SELECT Id FROM Attachment WHERE Parent.id = :objAcceptanceCriteria.Id].size(), 1, 'Attachment process failed.');
    }
}