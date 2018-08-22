/**
 * Test class for the trigger: TestCaseTrigger_FAT.
 * <p /><p />
 * @author: Alberto Gomez
 */
@isTest(seeAllData=false)
public class TestCaseTriggerTest_FAT {
    
    /**
     * This method tests the continuation methods.
     */
    @testSetup 
    static void setup() {
        
        //Create common test data.
        RecordType objRecordType;
        Release_FAT__c objRelease = new Release_FAT__c();
        Sprint_FAT__c objSprint = new Sprint_FAT__c();
        ProgramIncrement_FAT__c objProgramIncrement = new ProgramIncrement_FAT__c();
        Project_FAT__c objProject = new Project_FAT__c();
        Epic_FAT__c objEpic = new Epic_FAT__c();
        Feature_FAT__c objFeature = new Feature_FAT__c();
        UserStory_FAT__c objUserStory = new UserStory_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Component_FAT__c objComponent = new Component_FAT__c();
        FeatureBranch_FAT__c objFeatureBranchPositiveTest = new FeatureBranch_FAT__c();
        FeatureBranch_FAT__c objFeatureBranchNegativeTest = new FeatureBranch_FAT__c();
        List<TestCaseStep_FAT__c> lstCaseStep = new List<TestCaseStep_FAT__c>();

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
        objEnviroment.Name = 'DevTest';
        DMLOperationsClass_CF.insertRecord(objEnviroment);
        objComponent.Extension_FAT__c = 'cls';
        objComponent.Type_FAT__c = 'Apex Class';
        DMLOperationsClass_CF.insertRecord(objComponent);
    }
    
    /**
     * This method tests the TestCaseTrigger_FAT execution.
     */
    @isTest
    static void testTrigger() {
        TestCase_FAT__c objTestCase = new TestCase_FAT__c();
        TestCaseStep_FAT__c objTestCaseStep = new TestCaseStep_FAT__c();
        UserStory_FAT__c objUserStory = [SELECT Id FROM UserStory_FAT__c LIMIT 1];
        objTestCase.UserStory_FAT__c = objUserStory.Id;
        objTestCase.Name_FAT__c = 'Case Name 1';
        objTestCase.Description_FAT__c = 'Case Description 1';
        objTestCase.Status_FAT__c = 'Not Completed';
        insert objTestCase;
        objTestCaseStep.TestCase_FAT__c = objTestCase.Id;
        objTestCaseStep.Step_FAT__c = 10;
        objTestCaseStep.Priority_FAT__c = 'Medium';
        objTestCaseStep.Status_FAT__c = 'Failed';
        insert objTestCaseStep;
    }

    /**
     * This method tests TestCaseTrigger_FAT when updating a Test Case Step status.
     */
    @isTest
    static void testUpdateStepStatusTrigger() {
        TestCase_FAT__c objTestCase = new TestCase_FAT__c();
        TestCaseStep_FAT__c objTestCaseStep = new TestCaseStep_FAT__c();
        UserStory_FAT__c objUserStory = [SELECT Id FROM UserStory_FAT__c LIMIT 1];

        //Execute test.
        Test.startTest();

        //Create Case 1.
        objTestCase.UserStory_FAT__c = objUserStory.Id;
        objTestCase.Name_FAT__c = 'Case Name 1';
        objTestCase.Description_FAT__c = 'Case Description 1';
        objTestCase.Status_FAT__c = 'Not Completed';
        DMLOperationsClass_CF.insertRecord(objTestCase);

        //Create Step 1 for Case 1.
        objTestCaseStep.TestCase_FAT__c = objTestCase.Id;
        objTestCaseStep.Step_FAT__c = 10;
        objTestCaseStep.Priority_FAT__c = 'Medium';
        objTestCaseStep.Status_FAT__c = 'Failed';
        DMLOperationsClass_CF.insertRecord(objTestCaseStep);

        //Update Step 1 for Case 1. All Steps are 'Passed'.
        objTestCaseStep.Status_FAT__c = 'Passed';
        DMLOperationsClass_CF.updateRecord(objTestCaseStep);

        //Create Case 2.
        objTestCase = new TestCase_FAT__c();
        objTestCase.UserStory_FAT__c = objUserStory.Id;
        objTestCase.Name_FAT__c = 'Case Name 2';
        objTestCase.Description_FAT__c = 'Case Description 2';
        objTestCase.Status_FAT__c = 'Not Completed';
        DMLOperationsClass_CF.insertRecord(objTestCase);

        //Create Step 1 for Case 2.
        objTestCaseStep = new TestCaseStep_FAT__c();
        objTestCaseStep.TestCase_FAT__c = objTestCase.Id;
        objTestCaseStep.Step_FAT__c = 20;
        objTestCaseStep.Priority_FAT__c = 'Medium';
        objTestCaseStep.Status_FAT__c = 'Passed';
        DMLOperationsClass_CF.insertRecord(objTestCaseStep);

        //Update Step 2 for Case 2. All Steps are ''.
        objTestCaseStep.Status_FAT__c = 'Not Completed';
        DMLOperationsClass_CF.updateRecord(objTestCaseStep);

        //Create Case 3.
        objTestCase = new TestCase_FAT__c();
        objTestCase.UserStory_FAT__c = objUserStory.Id;
        objTestCase.Name_FAT__c = 'Case Name 3';
        objTestCase.Description_FAT__c = 'Case Description 3';
        objTestCase.Status_FAT__c = 'Not Completed';
        DMLOperationsClass_CF.insertRecord(objTestCase);

        //Create Step 1 for Case 3.
        objTestCaseStep = new TestCaseStep_FAT__c();
        objTestCaseStep.TestCase_FAT__c = objTestCase.Id;
        objTestCaseStep.Step_FAT__c = 30;
        objTestCaseStep.Priority_FAT__c = 'Medium';
        objTestCaseStep.Status_FAT__c = 'Blocked';
        DMLOperationsClass_CF.insertRecord(objTestCaseStep);

        //Update 1 Step 1 for Case 3
        objTestCaseStep.Status_FAT__c = 'Failed';
        DMLOperationsClass_CF.updateRecord(objTestCaseStep);

        //Update 2 Step 1 for Case 3
        objTestCaseStep.Status_FAT__c = 'Blocked';
        DMLOperationsClass_CF.updateRecord(objTestCaseStep);

        //Create Case 4.
        objTestCase = new TestCase_FAT__c();
        objTestCase.UserStory_FAT__c = objUserStory.Id;
        objTestCase.Name_FAT__c = 'Case Name 4';
        objTestCase.Description_FAT__c = 'Case Description 4';
        objTestCase.Status_FAT__c = 'Not Completed';
        DMLOperationsClass_CF.insertRecord(objTestCase);

        //Create Step 1 for Case 4.
        objTestCaseStep = new TestCaseStep_FAT__c();
        objTestCaseStep.TestCase_FAT__c = objTestCase.Id;
        objTestCaseStep.Step_FAT__c = 30;
        objTestCaseStep.Priority_FAT__c = 'Medium';
        objTestCaseStep.Status_FAT__c = 'Not Completed';
        DMLOperationsClass_CF.insertRecord(objTestCaseStep);

        //Create Case 5.
        objTestCase = new TestCase_FAT__c();
        objTestCase.UserStory_FAT__c = objUserStory.Id;
        objTestCase.Name_FAT__c = 'Case Name 5';
        objTestCase.Description_FAT__c = 'Case Description 5';
        objTestCase.Status_FAT__c = 'Not Completed';
        DMLOperationsClass_CF.insertRecord(objTestCase);

        //Create Step 1 for Case 5.
        objTestCaseStep = new TestCaseStep_FAT__c();
        objTestCaseStep.TestCase_FAT__c = objTestCase.Id;
        objTestCaseStep.Step_FAT__c = 30;
        objTestCaseStep.Priority_FAT__c = 'Medium';
        objTestCaseStep.Status_FAT__c = 'Not Completed';
        DMLOperationsClass_CF.insertRecord(objTestCaseStep);

        //Create Step 2 for Case 5.
        objTestCaseStep = new TestCaseStep_FAT__c();
        objTestCaseStep.TestCase_FAT__c = objTestCase.Id;
        objTestCaseStep.Step_FAT__c = 30;
        objTestCaseStep.Priority_FAT__c = 'Medium';
        objTestCaseStep.Status_FAT__c = 'Passed';
        DMLOperationsClass_CF.insertRecord(objTestCaseStep);

        //Create Step 3 for Case 5.
        objTestCaseStep = new TestCaseStep_FAT__c();
        objTestCaseStep.TestCase_FAT__c = objTestCase.Id;
        objTestCaseStep.Step_FAT__c = 30;
        objTestCaseStep.Priority_FAT__c = 'Medium';
        objTestCaseStep.Status_FAT__c = 'Passed';
        DMLOperationsClass_CF.insertRecord(objTestCaseStep);

        //Update Step 3 for Case 5.
        objTestCaseStep.Status_FAT__c = 'Not Completed';
        DMLOperationsClass_CF.updateRecord(objTestCaseStep);
        
        //Now we test the Not Started Scenario.
        objTestCase = new TestCase_FAT__c();
        objTestCase.UserStory_FAT__c = objUserStory.Id;
        objTestCase.Name_FAT__c = 'Case Name Not Started Scenario';
        objTestCase.Description_FAT__c = 'Case Description 5';
        objTestCase.Status_FAT__c = StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_NOT_STARTED;
        DMLOperationsClass_CF.insertRecord(objTestCase);
        objTestCaseStep = new TestCaseStep_FAT__c();
        objTestCaseStep.TestCase_FAT__c = objTestCase.Id;
        objTestCaseStep.Step_FAT__c = 30;
        objTestCaseStep.Priority_FAT__c = 'Medium';
        objTestCaseStep.Status_FAT__c = StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_NOT_STARTED;
        DMLOperationsClass_CF.insertRecord(objTestCaseStep);

        //Stop test.
        Test.stopTest();
    }
}