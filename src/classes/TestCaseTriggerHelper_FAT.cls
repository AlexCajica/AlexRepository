/**
 * This is a Helper class for UpdateCaseStatusTrigger_FAT
 * <p /><p />
 * @author Alberto Gomez
 */
 public without sharing class TestCaseTriggerHelper_FAT {

    /**
     * This method updates the Test Case Status.
     *
     * @param objTestStep   Test Step to  use a reference to search a Test Case to be updated or inserted with certain status.
     */
    public static void updateTestCaseStatus(TestCaseStep_FAT__c objTestCaseStep) {
        
        //We first make sure we have the Test Case Id.
        if(objTestCaseStep != null && objTestCaseStep.TestCase_FAT__c != null) {
            
            //We create the Test Case parent object.
            Boolean boolHasPassed = false;
            Boolean boolHasInProgress = false;
            Boolean boolHasNotStarted = false;
            Boolean boolHasFailed = false;
            Boolean boolHasBlocked = false;
            TestCase_FAT__c objTestCase = new TestCase_FAT__c();
            objTestCase.Id = objTestCaseStep.TestCase_FAT__c;
            
            //We first get all the child records.
            for(TestCaseStep_FAT__c objChildTestCaseStep : [SELECT Status_FAT__c FROM TestCaseStep_FAT__c WHERE TestCase_FAT__c = :objTestCase.Id LIMIT 1000]) {
                if(objChildTestCaseStep.Status_FAT__c == StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_FAILED) {
                    objTestCase.Status_FAT__c = StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_FAILED;
                    boolHasFailed = true;
                    break;
                } else if(objChildTestCaseStep.Status_FAT__c == StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_BLOCKED) {
                    objTestCase.Status_FAT__c = StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_BLOCKED;
                    boolHasBlocked = true;
                    break;
                } else if(objChildTestCaseStep.Status_FAT__c == StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_NOT_COMPLETED) {
                    boolHasInProgress = true;
                } else if(objChildTestCaseStep.Status_FAT__c == StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_NOT_STARTED) {
                    boolHasNotStarted = true;
                } else {
                    boolHasPassed = true;
                }
            }
            if(!boolHasFailed && !boolHasBlocked) {
                if(boolHasInProgress || (boolHasPassed && boolHasNotStarted)) {
                    objTestCase.Status_FAT__c = StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_NOT_COMPLETED;
                } else if(boolHasNotStarted) {
                    objTestCase.Status_FAT__c = StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_NOT_STARTED;
                } else {
                    objTestCase.Status_FAT__c = StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_PASSED;
                }
            }
            
            //Finally, we update the Test Case.
            update objTestCase;
        }
    }
}