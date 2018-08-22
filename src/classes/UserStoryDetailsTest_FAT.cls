/**
 * Test wrapper class to store the User Story and Acceptance Criteria details.
 * <p /><p />
 * @author Gabriel Coronel
 */
@isTest(SeeAllData=false)
public class UserStoryDetailsTest_FAT {
    
    /**
     * Method to create test data.
     */
    @testSetup
    static void createTestData() {

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
        insert objProject;
        objRelease.Description_FAT__c = 'Release Test';
        objRelease.Project_FAT__c = objProject.Id;
        insert objRelease;
        objSprint.SprintName_FAT__c = 'Test Sprint';
        objSprint.StartDate_FAT__c = System.today();
        objSprint.EndDate_FAT__c = System.today();
        objSprint.Release_FAT__c = objRelease.Id;
        insert objSprint;
        objProgramIncrement.Description_FAT__c = 'Program Increment Description';
        insert objProgramIncrement;
        objEpic.Description_FAT__c = 'Epic Description';
        objEpic.Project_FAT__c = objProject.Id;
        insert objEpic;
        objFeature.Description_FAT__c = 'Feature Description';
        objFeature.Epic_FAT__c = objEpic.Id;
        insert objFeature;
        objUserStory.Title__c = 'US Title';
        objUserStory.Description_FAT__c = 'User Story Description';
        objUserStory.Status_FAT__c = 'Open';
        objUserStory.StoryPoints_FAT__c = 1;
        objUserStory.Feature_FAT__c = objFeature.Id;
        objUserStory.ProgramIncrement_FAT__c = objProgramIncrement.Id;
        objUserStory.Sprint_FAT__c = objSprint.Id;
        insert objUserStory;
    }

    /**
     * Method to test class instance.
     */
    @isTest
    static void createUserStoryDetails() {
        UserStory_FAT__c objUserStory = new UserStory_FAT__c();
        objUserStory = [SELECT Id, Name FROM UserStory_FAT__c LIMIT 1];

        //Execute test.
        Test.startTest();
        UserStoryDetailsClass_FAT objUserStoryDetails = new UserStoryDetailsClass_FAT(objUserStory);
        System.assertEquals(objUserStoryDetails.objUserStory, objUserStory, 'User story must be the same');
        Test.stopTest();
    }
}