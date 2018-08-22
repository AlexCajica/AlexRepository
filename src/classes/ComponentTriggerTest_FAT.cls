/**
 * Test class for trigger ComponentTrigger_FAT.
 * <p /><p />
 * @author: Raymundo Rodriguez
 */
@isTest(seeAllData = false)
public without sharing class ComponentTriggerTest_FAT {
    
    /**
     * This method tests the continuation methods.
     */
    @testSetup 
    static void setup() {
        
        //Create common test data.
        Project_FAT__c objProject = new Project_FAT__c();

        //Setting and inserting values.
        objProject.Name = '1';
        objProject.Description_FAT__c = 'Test Description';
        DMLOperationsClass_CF.insertRecord(objProject);
    }
    
    /**
     * This method tests the insertion of Components with different data.
     */
    @isTest
    static void newComponentsWithDifferentData() {
        
        //We first get one value from the Type picklist.
        String strType;
        Project_FAT__c objProjectOne = [SELECT Id FROM Project_FAT__c WHERE Name = '1' LIMIT 1];
        for(Schema.PicklistEntry objPicklist : Component_FAT__c.Type_FAT__c.getDescribe().getPicklistValues()) {
            strType = objPicklist.getValue();
        }
        
        //If the picklist doesn't have a value.
        System.assertNotEquals(strType, '', 'Type Picklist does not have any values.');
        
        //Now we create the Components.
        Test.startTest();
        Component_FAT__c objComponent = new Component_FAT__c();
        objComponent.APIName_FAT__c = 'Test1';
        objComponent.Type_FAT__c = strType;
        objComponent.Project_FAT__c = objProjectOne.Id;
        DMLOperationsClass_CF.insertRecord(objComponent);
        objComponent = new Component_FAT__c();
        objComponent.APIName_FAT__c = 'Test2';
        objComponent.Type_FAT__c = strType;
        objComponent.Project_FAT__c = objProjectOne.Id;
        DMLOperationsClass_CF.insertRecord(objComponent);
        
        //Now we update one of the components to match the first one.
        objComponent.APIName_FAT__c = 'Test1';
        DMLOperationsClass_CF.updateRecord(objComponent);
          
        Test.stopTest();
        System.assertEquals([SELECT Id FROM Component_FAT__c].size(), 2, 'Component process failed.');
    }
    
    /**
     * This method tests the insertion of Components with different data.
     */
    @isTest
    static void newComponentsWithSimilarData() {
        
        //We first get one value from the Type picklist.
        String strType;
        Project_FAT__c objProjectOne = [SELECT Id FROM Project_FAT__c WHERE Name = '1' LIMIT 1];
        for(Schema.PicklistEntry objPicklist : Component_FAT__c.Type_FAT__c.getDescribe().getPicklistValues()) {
            strType = objPicklist.getValue();
        }
        
        //If the picklist doesn't have a value.
        System.assertNotEquals(strType, '', 'Type Picklist does not have any values.');
        
        //Now we create the Components.
        Test.startTest();
        Component_FAT__c objComponent = new Component_FAT__c();
        objComponent.APIName_FAT__c = 'Test1';
        objComponent.Type_FAT__c = strType;
        objComponent.Project_FAT__c = objProjectOne.Id;
        DMLOperationsClass_CF.insertRecord(objComponent);
        objComponent = new Component_FAT__c();
        objComponent.APIName_FAT__c = 'Test1';
        objComponent.Type_FAT__c = strType;
        objComponent.Project_FAT__c = objProjectOne.Id;
        DMLOperationsClass_CF.insertRecord(objComponent);

        Test.stopTest();
        System.assertEquals([SELECT Id FROM Component_FAT__c].size(), 1, 'Component process failed.');
    }
    
    /**
     * This method tests the insertion of Components with different data.
     */
    @isTest
    static void newComponentsSameTimeWithSimilarData() {
        
        //We first get one value from the Type picklist.
        String strType;
        Project_FAT__c objProjectOne = [SELECT Id FROM Project_FAT__c WHERE Name = '1' LIMIT 1];
        for(Schema.PicklistEntry objPicklist : Component_FAT__c.Type_FAT__c.getDescribe().getPicklistValues()) {
            strType = objPicklist.getValue();
        }
        
        //If the picklist doesn't have a value.
        System.assertNotEquals(strType, '', 'Type Picklist does not have any values.');
        
        //Now we create the Components.
        Test.startTest();
        List<Component_FAT__c> lstComponents = new List<Component_FAT__c>();
        Component_FAT__c objComponentOne = new Component_FAT__c();
        objComponentOne.APIName_FAT__c = 'Test1';
        objComponentOne.Type_FAT__c = strType;
        objComponentOne.Project_FAT__c = objProjectOne.Id;
        lstComponents.add(objComponentOne);
        Component_FAT__c objComponentTwo = new Component_FAT__c();
        objComponentTwo.APIName_FAT__c = 'Test1';
        objComponentTwo.Type_FAT__c = strType;
        objComponentTwo.Project_FAT__c = objProjectOne.Id;
        lstComponents.add(objComponentTwo);
        DMLOperationsClass_CF.insertRecords(lstComponents);
          
        Test.stopTest();
        System.assertEquals([SELECT Id FROM Component_FAT__c].size(), 0, 'Component process failed.');
    }
}