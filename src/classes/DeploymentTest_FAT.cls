/**
 * Apex class to create package file to deploy.
 * <p /><p />
 * @author Gabriel Coronel. 
 */
@isTest
public class DeploymentTest_FAT {

    /**
     * Create test data.
     */
    @testSetup
    static void createTestData() {
        //Create common test data.
        RecordType objRecordType;
        RecordType objBugRecordType;
        RecordType objFeatureBranchComponentRecordType;
        Release_FAT__c objRelease = new Release_FAT__c();
        Sprint_FAT__c objSprint = new Sprint_FAT__c();
        ProgramIncrement_FAT__c objProgramIncrement = new ProgramIncrement_FAT__c();
        Project_FAT__c objProject = new Project_FAT__c();
        Epic_FAT__c objEpic = new Epic_FAT__c();
        Feature_FAT__c objFeature = new Feature_FAT__c();
        UserStory_FAT__c objUserStory = new UserStory_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Component_FAT__c objComponent = new Component_FAT__c();
        Component_FAT__c objComponentForDeletion = new Component_FAT__c();
        Component_FAT__c objComponentPreDeletion = new Component_FAT__c();
        Component_FAT__c objComponentPostDeletion = new Component_FAT__c();
        FeatureBranchComponent_FAT__c objFeatureBranchComponent = new FeatureBranchComponent_FAT__c();
        FeatureBranchComponent_FAT__c objFeatureBranchComponentForDeletion = new FeatureBranchComponent_FAT__c();
        FeatureBranchComponent_FAT__c objFeatureBranchComponentPreDeletion = new FeatureBranchComponent_FAT__c();
        FeatureBranchComponent_FAT__c objFeatureBranchComponentPostDeletion = new FeatureBranchComponent_FAT__c();
        FeatureBranchComponent_FAT__c objFeatureBranchComponentRepeated = new FeatureBranchComponent_FAT__c();
        FeatureBranchComponent_FAT__c objFeatureBranchComponentRepeatedForDeletion = new FeatureBranchComponent_FAT__c();
        FeatureBranchComponent_FAT__c objFeatureBranchComponentPreDeploymentManualStep = new FeatureBranchComponent_FAT__c();
        FeatureBranchComponent_FAT__c objFeatureBranchComponentPostDeploymentManualStep = new FeatureBranchComponent_FAT__c();
        FeatureBranch_FAT__c objFeatureBranchPositiveTest = new FeatureBranch_FAT__c();
        FeatureBranch_FAT__c objFeatureBranchNegativeTest = new FeatureBranch_FAT__c();
        FeatureBranch_FAT__c objFeatureBranchPositiveTestBug = new FeatureBranch_FAT__c();
        FeatureBranch_FAT__c objFeatureBranchNegativeTestBug = new FeatureBranch_FAT__c();
        TestCase_FAT__c objTestCase = new TestCase_FAT__c();
        Bug_FAT__c objBug = new Bug_FAT__c();
        
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
        objEnviroment.Name = 'DevTest';
        insert objEnviroment;
        objComponent.APIName_FAT__c = 'Test Component';
        objComponent.Project_FAT__c = objProject.Id;
        objComponent.Extension_FAT__c = 'cls';
        objComponent.Type_FAT__c = 'ApexClass';
        insert objComponent;
        objComponentForDeletion.APIName_FAT__c = 'Test Component for Deletion';
        objComponentForDeletion.Project_FAT__c = objProject.Id;
        objComponentForDeletion.Extension_FAT__c = 'cls';
        objComponentForDeletion.Type_FAT__c = 'ApexClass';
        insert objComponentForDeletion;
        objComponentPreDeletion.APIName_FAT__c = 'Test Component Pre Deletion';
        objComponentPreDeletion.Project_FAT__c = objProject.Id;
        objComponentPreDeletion.Extension_FAT__c = 'cls';
        objComponentPreDeletion.Type_FAT__c = 'ApexClass';
        insert objComponentPreDeletion;
        objComponentPostDeletion.APIName_FAT__c = 'Test Component Post Deletion';
        objComponentPostDeletion.Project_FAT__c = objProject.Id;
        objComponentPostDeletion.Extension_FAT__c = 'cls';
        objComponentPostDeletion.Type_FAT__c = 'ApexClass';
        insert objComponentPostDeletion;
        objTestCase.Description_FAT__c = 'Test';
        objTestCase.Name_FAT__c = 'Test';
        objTestCase.Status_FAT__c = 'Failed';
        objTestCase.UserStory_FAT__c = objUserStory.Id;
        insert objTestCase;
        objBug.Name_FAT__c = 'Test';
        objBug.TestCase_FAT__c = objTestCase.Id;
        objBug.DetectedIn_FAT__c = objEnviroment.Id;
        objBug.Type_FAT__c = 'Defect';
        objBug.Priority_FAT__c = 'Low';
        objBug.Severity_FAT__c = 'Low';
        objBug.Status_FAT__c = 'Open';
        objBug.AssignedTo_FAT__c = UserInfo.getUserId();
        objBug.TargetDate_FAT__c = System.today();
        objBug.Description_FAT__c = 'Test';
        insert objBug;
        
        //Create feature branches.
        Test.setMock(HttpCalloutMock.class, new MockHttpRepositoryRespTest_FAT());
        objRecordType = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'FeatureBranch_FAT__c' AND Name = 'User Story' LIMIT 1];
        objFeatureBranchPositiveTest.RecordTypeId = objRecordType.Id;
        objFeatureBranchPositiveTest.UserStory_FAT__c = objUserStory.Id;
        objFeatureBranchPositiveTest.CreatedOnRepository_FAT__c = true;
        objFeatureBranchPositiveTest.Destination_FAT__c = objEnviroment.Id;
        objFeatureBranchPositiveTest.Origin_FAT__c = objEnviroment.Id;
        objFeatureBranchPositiveTest.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchPositiveTest;
        objFeatureBranchComponent.RecordTypeId = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Metadata Development').getRecordTypeId();
        objFeatureBranchComponent.FeatureBranch_FAT__c = objFeatureBranchPositiveTest.Id;
        objFeatureBranchComponent.Component_FAT__c = objComponent.Id;
        objFeatureBranchComponent.MetadataAction_FAT__c = 'Insert/Update';
        objFeatureBranchComponent.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchComponent;
        objFeatureBranchComponentForDeletion.RecordTypeId = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Metadata Development').getRecordTypeId();
        objFeatureBranchComponentForDeletion.FeatureBranch_FAT__c = objFeatureBranchPositiveTest.Id;
        objFeatureBranchComponentForDeletion.Component_FAT__c = objComponentForDeletion.Id;
        objFeatureBranchComponentForDeletion.MetadataAction_FAT__c = 'Insert/Update';
        objFeatureBranchComponentForDeletion.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchComponentForDeletion;
        objFeatureBranchComponentPreDeletion.RecordTypeId = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Metadata Development').getRecordTypeId();
        objFeatureBranchComponentPreDeletion.FeatureBranch_FAT__c = objFeatureBranchPositiveTest.Id;
        objFeatureBranchComponentPreDeletion.Component_FAT__c = objComponentPreDeletion.Id;
        objFeatureBranchComponentPreDeletion.MetadataAction_FAT__c = 'Pre-Deletion';
        objFeatureBranchComponentPreDeletion.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchComponentPreDeletion;
        objFeatureBranchComponentPostDeletion.RecordTypeId = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Metadata Development').getRecordTypeId();
        objFeatureBranchComponentPostDeletion.FeatureBranch_FAT__c = objFeatureBranchPositiveTest.Id;
        objFeatureBranchComponentPostDeletion.Component_FAT__c = objComponentPostDeletion.Id;
        objFeatureBranchComponentPostDeletion.MetadataAction_FAT__c = 'Post-Deletion';
        objFeatureBranchComponentPostDeletion.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchComponentPostDeletion;
        objFeatureBranchComponentRepeated.RecordTypeId = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Metadata Development').getRecordTypeId();
        objFeatureBranchComponentRepeated.FeatureBranch_FAT__c = objFeatureBranchPositiveTest.Id;
        objFeatureBranchComponentRepeated.Component_FAT__c = objComponent.Id;
        objFeatureBranchComponentRepeated.MetadataAction_FAT__c = 'Insert/Update';
        objFeatureBranchComponentRepeated.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchComponentRepeated;
        objFeatureBranchComponentPreDeploymentManualStep.RecordTypeId = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Manual Step Development').getRecordTypeId();
        objFeatureBranchComponentPreDeploymentManualStep.FeatureBranch_FAT__c = objFeatureBranchPositiveTest.Id;
        objFeatureBranchComponentPreDeploymentManualStep.DeploymentOrder_FAT__c = 'Pre-deployment';
        objFeatureBranchComponentPreDeploymentManualStep.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchComponentPreDeploymentManualStep;
        objFeatureBranchComponentPostDeploymentManualStep.RecordTypeId = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Manual Step Development').getRecordTypeId();
        objFeatureBranchComponentPostDeploymentManualStep.FeatureBranch_FAT__c = objFeatureBranchPositiveTest.Id;
        objFeatureBranchComponentPostDeploymentManualStep.DeploymentOrder_FAT__c = 'Post-deployment';
        objFeatureBranchComponentPostDeploymentManualStep.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchComponentPostDeploymentManualStep;
        objFeatureBranchComponentRepeatedForDeletion.RecordTypeId = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Metadata Development').getRecordTypeId();
        objFeatureBranchComponentRepeatedForDeletion.FeatureBranch_FAT__c = objFeatureBranchPositiveTest.Id;
        objFeatureBranchComponentRepeatedForDeletion.Component_FAT__c = objComponentForDeletion.Id;
        objFeatureBranchComponentRepeatedForDeletion.MetadataAction_FAT__c = 'Pre-Deletion';
        objFeatureBranchComponentRepeatedForDeletion.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchComponentRepeatedForDeletion;
        objFeatureBranchNegativeTest.RecordTypeId = objRecordType.Id;
        objFeatureBranchNegativeTest.UserStory_FAT__c = objUserStory.Id;
        objFeatureBranchNegativeTest.CreatedOnRepository_FAT__c = false;
        objFeatureBranchNegativeTest.Destination_FAT__c = objEnviroment.Id;
        objFeatureBranchNegativeTest.Origin_FAT__c = objEnviroment.Id;
        objFeatureBranchNegativeTest.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchNegativeTest;
        objBugRecordType = [SELECT Id,Name FROM RecordType WHERE SobjectType = 'FeatureBranch_FAT__c' AND Name = 'Bug' LIMIT 1];
        objFeatureBranchPositiveTestBug.RecordTypeId = objBugRecordType.Id;
        objFeatureBranchPositiveTestBug.Bug_FAT__c = objBug.Id;
        objFeatureBranchPositiveTestBug.CreatedOnRepository_FAT__c = true;
        objFeatureBranchPositiveTestBug.Destination_FAT__c = objEnviroment.Id;
        objFeatureBranchPositiveTestBug.Origin_FAT__c = objEnviroment.Id;
        objFeatureBranchPositiveTestBug.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchPositiveTestBug;
        objFeatureBranchNegativeTestBug.RecordTypeId = objBugRecordType.Id;
        objFeatureBranchNegativeTestBug.Bug_FAT__c = objBug.Id;
        objFeatureBranchNegativeTestBug.CreatedOnRepository_FAT__c = false;
        objFeatureBranchNegativeTestBug.Destination_FAT__c = objEnviroment.Id;
        objFeatureBranchNegativeTestBug.Origin_FAT__c = objEnviroment.Id;
        objFeatureBranchNegativeTestBug.Status_FAT__c = 'Ready for Deployment';
        insert objFeatureBranchNegativeTestBug;
    }

    /**
     * Method to test deployment creation.
     */
    @isTest
    static void testDeploymentCreation() {
        Deployment_FAT__c objDeployment = new Deployment_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Apexpages.StandardController objStandardController = new Apexpages.StandardController(objDeployment);
        DeploymentController_FAT objDeploymentController = new DeploymentController_FAT(objStandardController);
        objEnviroment = [SELECT Id FROM Environment_FAT__c];
        objDeploymentController.strOrigin = objEnviroment.Id;
        objDeploymentController.strDestination = objEnviroment.Id;
        objDeploymentController.strNextEnvironment = objEnviroment.Id;

        //Execute test.
        Test.startTest();
        objDeploymentController.createDeploymentRecord();
        System.assertEquals(objDeploymentController.lstDeploymentComponents.size(), 4, 'List must have 4 elements');
        Test.stopTest();
    }

    /**
     * Method to test deployment creation exception.
     */
    @isTest
    static void testDeploymentCreationException() {
        Deployment_FAT__c objDeployment = new Deployment_FAT__c();

        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Apexpages.StandardController objStandardController = new Apexpages.StandardController(objDeployment);
        DeploymentController_FAT objDeploymentController = new DeploymentController_FAT(objStandardController);
        objEnviroment = [SELECT Id FROM Environment_FAT__c];
        objDeploymentController.strOrigin = objEnviroment.Id;
        objDeploymentController.strDestination = objEnviroment.Id;

        //Execute test.
        Test.startTest();
        objDeploymentController.createDeploymentRecord();
        System.assertEquals(objDeploymentController.lstDeploymentComponents, null, 'List must have null');
        Test.stopTest();
    }

    /**
     * Method to test deployment opened.
     */
    @isTest
    static void testOpenDeployment() {
        Deployment_FAT__c objDeployment = new Deployment_FAT__c();
        Deployment_FAT__c objDeploymentInserted = new Deployment_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Apexpages.StandardController objStandardController = new Apexpages.StandardController(objDeployment);
        DeploymentController_FAT objDeploymentController = new DeploymentController_FAT(objStandardController);
        objEnviroment = [SELECT Id FROM Environment_FAT__c];
        objDeploymentController.strOrigin = objEnviroment.Id;
        objDeploymentController.strDestination = objEnviroment.Id;
        objDeploymentController.strNextEnvironment = objEnviroment.Id;
        objDeploymentController.createDeploymentRecord();
        objDeploymentInserted = [SELECT Id FROM Deployment_FAT__c LIMIT 1];

        //Execute test.
        Test.startTest();
        Apexpages.StandardController objStandardControllerOpen = new Apexpages.StandardController(objDeploymentInserted);
        DeploymentController_FAT objOpenDeployment = new DeploymentController_FAT(objStandardControllerOpen);
        System.assertEquals(objDeploymentController.lstPreDeploymentManualSteps.size(), 1, 'List must have 1 element');
        Test.stopTest();
    }

    /**
     * Method to test deployment packages creation.
     */
    @isTest
    static void testDeploymentPackage() {
        Deployment_FAT__c objDeployment = new Deployment_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Apexpages.StandardController objStandardController = new Apexpages.StandardController(objDeployment);
        DeploymentController_FAT objDeploymentController = new DeploymentController_FAT(objStandardController);
        objEnviroment = [SELECT Id FROM Environment_FAT__c];
        objDeploymentController.strOrigin = objEnviroment.Id;
        objDeploymentController.strDestination = objEnviroment.Id;
        objDeploymentController.strNextEnvironment = objEnviroment.Id;
        objDeploymentController.createDeploymentRecord();
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponent : objDeploymentController.lstDeploymentComponents) {
            objDeploymentComponent.boolIsApproved = true;
        }

        //Execute test.
        Test.startTest();
        objDeploymentController.createDeploymentPackages();
        System.assertEquals(objDeploymentController.lstPostDeploymentManualSteps.size(), 1, 'List must have 1 element');
        Test.stopTest();
    }

    /**
     * Method to test deployment package update.
     */
    @isTest
    static void testUpdateDeploymentPackage() {
        Deployment_FAT__c objDeployment = new Deployment_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Apexpages.StandardController objStandardController = new Apexpages.StandardController(objDeployment);
        DeploymentController_FAT objDeploymentController = new DeploymentController_FAT(objStandardController);
        objEnviroment = [SELECT Id FROM Environment_FAT__c];
        objDeploymentController.strOrigin = objEnviroment.Id;
        objDeploymentController.strDestination = objEnviroment.Id;
        objDeploymentController.strNextEnvironment = objEnviroment.Id;
        objDeploymentController.createDeploymentRecord();
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponent : objDeploymentController.lstDeploymentComponents) {
            objDeploymentComponent.boolIsApproved = true;
        }
        objDeploymentController.createDeploymentPackages();

        //Execute test.
        Test.startTest();
        objDeploymentController.createDeploymentPackages();
        System.assertEquals(objDeploymentController.lstDeploymentComponents.size(), 4, 'List must have 4 records');
        Test.stopTest();
    }

    /**
     * Method to test task creation for rejected components.
     */
    @isTest
    static void testTaskCreationForRejectedComponents() {
        Boolean boolIsApproved;
        Deployment_FAT__c objDeployment = new Deployment_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Apexpages.StandardController objStandardController = new Apexpages.StandardController(objDeployment);
        DeploymentController_FAT objDeploymentController = new DeploymentController_FAT(objStandardController);
        objEnviroment = [SELECT Id FROM Environment_FAT__c];
        objDeploymentController.strOrigin = objEnviroment.Id;
        objDeploymentController.strDestination = objEnviroment.Id;
        objDeploymentController.strNextEnvironment = objEnviroment.Id;
        objDeploymentController.createDeploymentRecord();
        boolIsApproved = false;
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponent : objDeploymentController.lstDeploymentComponents) {
            objDeploymentComponent.boolIsApproved = boolIsApproved;
            objDeploymentComponent.strRejectionReason = 'Test ' + System.now().time();
            boolIsApproved = !boolIsApproved;
        }
        for(DeploymentManualStepsWrapperClass_FAT objPreDeploymentManualStep : objDeploymentController.lstPreDeploymentManualSteps) {
            objPreDeploymentManualStep.boolIsApproved = false;
            objPreDeploymentManualStep.strRejectionReason = 'Test ' + System.now().time();
        }
        for(DeploymentManualStepsWrapperClass_FAT objPostDeploymentManualStep : objDeploymentController.lstPostDeploymentManualSteps) {
            objPostDeploymentManualStep.boolIsApproved = false;
            objPostDeploymentManualStep.strRejectionReason = 'Test ' + System.now().time();
        }

        //Execute test.
        Test.startTest();
        objDeploymentController.finishDeployment();
        System.assertEquals(objDeploymentController.lstDeploymentComponents.size(), 4, 'List must have 4 records');
        Test.stopTest();
    }

    /**
     * Method to test open finished deployment.
     */
    @isTest
    static void testOpenDeploymentFinished() {
        Deployment_FAT__c objDeployment = new Deployment_FAT__c();
        Deployment_FAT__c objDeploymentInserted = new Deployment_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Apexpages.StandardController objStandardController = new Apexpages.StandardController(objDeployment);
        DeploymentController_FAT objDeploymentController = new DeploymentController_FAT(objStandardController);
        objEnviroment = [SELECT Id FROM Environment_FAT__c];
        objDeploymentController.strOrigin = objEnviroment.Id;
        objDeploymentController.strDestination = objEnviroment.Id;
        objDeploymentController.strNextEnvironment = objEnviroment.Id;
        objDeploymentController.createDeploymentRecord();
        objDeploymentInserted = [SELECT Id FROM Deployment_FAT__c LIMIT 1];
        objDeploymentInserted.DeploymentFinished_FAT__c = System.now();
        update objDeploymentInserted;

        //Execute test.
        Test.startTest();
        Apexpages.StandardController objStandardControllerOpen = new Apexpages.StandardController(objDeploymentInserted);
        DeploymentController_FAT objOpenDeployment = new DeploymentController_FAT(objStandardControllerOpen);
        System.assertEquals(objDeploymentController.lstDeploymentComponents.size(), 4, 'List must have 4 records');
        Test.stopTest();
    }

    /**
     * Method to test all deployment components approved.
     */
    @isTest
    static void testAllComponentsApproved() {
        Deployment_FAT__c objDeployment = new Deployment_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Apexpages.StandardController objStandardController = new Apexpages.StandardController(objDeployment);
        DeploymentController_FAT objDeploymentController = new DeploymentController_FAT(objStandardController);
        objEnviroment = [SELECT Id FROM Environment_FAT__c];
        objDeploymentController.strOrigin = objEnviroment.Id;
        objDeploymentController.strDestination = objEnviroment.Id;
        objDeploymentController.strNextEnvironment = objEnviroment.Id;
        objDeploymentController.createDeploymentRecord();
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponent : objDeploymentController.lstDeploymentComponents) {
            objDeploymentComponent.boolIsApproved = true;
            objDeploymentComponent.strRejectionReason = 'Test ' + System.now().time();
        }
        for(DeploymentManualStepsWrapperClass_FAT objPreDeploymentManualStep : objDeploymentController.lstPreDeploymentManualSteps) {
            objPreDeploymentManualStep.boolIsApproved = true;
            objPreDeploymentManualStep.strRejectionReason = 'Test ' + System.now().time();
        }
        for(DeploymentManualStepsWrapperClass_FAT objPostDeploymentManualStep : objDeploymentController.lstPostDeploymentManualSteps) {
            objPostDeploymentManualStep.boolIsApproved = true;
            objPostDeploymentManualStep.strRejectionReason = 'Test ' + System.now().time();
        }

        //Execute test.
        Test.startTest();
        objDeploymentController.finishDeployment();
        System.assertEquals(objDeploymentController.lstDeploymentComponents.size(), 4, 'List must have 4 records');
        Test.stopTest();
    }

    /**
     * Method to test table pagination and auto save.
     */
    @isTest
    static void testTablePaginations() {
        Deployment_FAT__c objDeployment = new Deployment_FAT__c();
        Environment_FAT__c objEnviroment = new Environment_FAT__c();
        Apexpages.StandardController objStandardController = new Apexpages.StandardController(objDeployment);
        DeploymentController_FAT objDeploymentController = new DeploymentController_FAT(objStandardController);
        objEnviroment = [SELECT Id FROM Environment_FAT__c];
        objDeploymentController.strOrigin = objEnviroment.Id;
        objDeploymentController.strDestination = objEnviroment.Id;
        objDeploymentController.strNextEnvironment = objEnviroment.Id;
        objDeploymentController.createDeploymentRecord();

        //Execute test.
        Test.startTest();
        objDeploymentController.goToDeploymentComponents();
        objDeploymentController.goToPreDeploymentManualSteps();
        objDeploymentController.goToPostDeploymentManualSteps();
        System.assertEquals(objDeploymentController.lstDeploymentComponents.size(), 4, 'List must have 4 records');
        Test.stopTest();
    }
}