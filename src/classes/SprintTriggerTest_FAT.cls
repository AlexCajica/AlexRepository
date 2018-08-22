/**
 * Test class for trigger SprintTrigger_FAT.
 * <p /><p />
 * @author: Raymundo Rodriguez
 */
@isTest(seeAllData = false)
public without sharing class SprintTriggerTest_FAT {
    
    /**
     * This method tests the continuation methods.
     */
    @testSetup 
    static void setup() {
        
        //Create common test data.
        Project_FAT__c objProject = new Project_FAT__c();
        Release_FAT__c objRelease = new Release_FAT__c();

        //Setting and inserting values.
        objProject.Name = '1';
        objProject.Description_FAT__c = 'Test Description';
        DMLOperationsClass_CF.insertRecord(objProject);
        objRelease.Description_FAT__c = 'Release Test';
        objRelease.Project_FAT__c = objProject.Id;
        DMLOperationsClass_CF.insertRecord(objRelease);
    }
    
    /**
     * This method tests the insertion of Sprints with different data.
     */
    @isTest
    static void newSprintsWithDifferentData() {
        
        //We first get one value from the Type picklist.
        Release_FAT__c objRelease = [SELECT Id FROM Release_FAT__c];
        
        //Now we create the Sprints.
        Test.startTest();
        Sprint_FAT__c objSprint = new Sprint_FAT__c();
        objSprint.SprintName_FAT__c = 'Test1';
        objSprint.Release_FAT__c = objRelease.Id;
        objSprint.StartDate_FAT__c = System.today();
        objSprint.EndDate_FAT__c = System.today();
        DMLOperationsClass_CF.insertRecord(objSprint);
        objSprint = new Sprint_FAT__c();
        objSprint.SprintName_FAT__c = 'Test2';
        objSprint.Release_FAT__c = objRelease.Id;
        objSprint.StartDate_FAT__c = System.today();
        objSprint.EndDate_FAT__c = System.today();
        DMLOperationsClass_CF.insertRecord(objSprint);
        
        //Now we update one of the Sprints to match the first one.
        objSprint.SprintName_FAT__c = 'Test1';
        DMLOperationsClass_CF.updateRecord(objSprint);
          
        Test.stopTest();
        System.assertEquals([SELECT Id FROM Sprint_FAT__c].size(), 2, 'Sprint process failed.');
    }
    
    /**
     * This method tests the insertion of Sprints with different data.
     */
    @isTest
    static void newSprintsWithSimilarData() {
        
        //We first get one value from the Type picklist.
        Release_FAT__c objRelease = [SELECT Id FROM Release_FAT__c];
        
        //Now we create the Sprints.
        Test.startTest();
        Sprint_FAT__c objSprint = new Sprint_FAT__c();
        objSprint.SprintName_FAT__c = 'Test1';
        objSprint.Release_FAT__c = objRelease.Id;
        objSprint.StartDate_FAT__c = System.today();
        objSprint.EndDate_FAT__c = System.today();
        DMLOperationsClass_CF.insertRecord(objSprint);
        objSprint = new Sprint_FAT__c();
        objSprint.SprintName_FAT__c = 'Test1';
        objSprint.Release_FAT__c = objRelease.Id;
        objSprint.StartDate_FAT__c = System.today();
        objSprint.EndDate_FAT__c = System.today();
        DMLOperationsClass_CF.insertRecord(objSprint);

        Test.stopTest();
        System.assertEquals([SELECT Id FROM Sprint_FAT__c].size(), 1, 'Sprint process failed.');
    }
    
    /**
     * This method tests the insertion of Sprints with different data.
     */
    @isTest
    static void newSprintsSameTimeWithSimilarData() {
        
        //We first get one value from the Type picklist.
        Release_FAT__c objRelease = [SELECT Id FROM Release_FAT__c];
        
        //Now we create the Sprints.
        Test.startTest();
        List<Sprint_FAT__c> lstSprints = new List<Sprint_FAT__c>();
        Sprint_FAT__c objSprintOne = new Sprint_FAT__c();
        objSprintOne.SprintName_FAT__c = 'Test1';
        objSprintOne.Release_FAT__c = objRelease.Id;
        objSprintOne.StartDate_FAT__c = System.today();
        objSprintOne.EndDate_FAT__c = System.today();
        lstSprints.add(objSprintOne);
        Sprint_FAT__c objSprintTwo = new Sprint_FAT__c();
        objSprintTwo.SprintName_FAT__c = 'Test1';
        objSprintTwo.Release_FAT__c = objRelease.Id;
        objSprintTwo.StartDate_FAT__c = System.today();
        objSprintTwo.EndDate_FAT__c = System.today();
        lstSprints.add(objSprintTwo);
        DMLOperationsClass_CF.insertRecords(lstSprints);
          
        Test.stopTest();
        System.assertEquals([SELECT Id FROM Sprint_FAT__c].size(), 0, 'Sprint process failed.');
    }
}