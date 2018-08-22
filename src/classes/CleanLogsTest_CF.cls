/**
 * This class tests the Scheduled Jobs for cleaning the Error Logs and Integration Detail records.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
@isTest(seeAllData = false)
private class CleanLogsTest_CF {

    /**
     * Setup test data.
     */
    @TestSetup
    static void setupData() {
        
        //We first create an Error Log record.
        try {
            Integer intResult = 1 / 0;
        } catch(Exception objException) {
            ErrorLog_CF__c objNewException;
            objNewException = new ErrorLog_CF__c();
            objNewException = ErrorLogClass_CF.extractExceptionCaller(objException, objNewException);
            objNewException.Message_CF__c = objException.getMessage();
            objNewException.StackTrace_CF__c = objException.getStackTraceString();
            insert objNewException;
        }
        
        //Now we create an Integration Log record.
        IntegrationClass_CF.saveIntegrationDetails('12345', 'https://test.salesforce.com', 'testRequest', 'testResponse');
    }
    
    /**
     * Method to test the Schedulable class.
     */
    @isTest
    static void testSchedulableClass() {
        Test.startTest();
        
        //We first cchedule the test job for Error Logs.
        String strCRONPatter = '0 5 8 ? * SUN'; 
        String strErrorLogsJobId = System.schedule('Clean Error Logs Test', strCRONPatter, new CleanErrorLogsClass_CF()); 
        String strIntegrationLogsJobId = System.schedule('Clean Integration Logs Test', strCRONPatter, new CleanIntegrationLogsClass_CF());

        //Now we get the information from the CronTrigger API object.
        for(CronTrigger objCronTrigger : [SELECT CronExpression, TimesTriggered FROM CronTrigger WHERE Id = :strErrorLogsJobId OR Id = :strIntegrationLogsJobId]) {
            
            //We first verify the expressions are the same.
            System.assertEquals(strCRONPatter, objCronTrigger.CronExpression, 'Invalid CRON expression.');
            
            //Now we check the Job has not run yet.
            System.assertEquals(0, objCronTrigger.TimesTriggered, 'Job not started.');
        }
        Test.stopTest();
    }
    
    /**
     * Method to test the Error Logs Apex Job class.
     */
    @isTest
    static void testErrorLogsJobClass() {
        
        //We first check the Error Logs.
        System.assertEquals(1, database.countquery('SELECT COUNT() FROM ' + ErrorLog_CF__c.class.toString()), 'No error logs found.');
        Test.startTest();
        Database.executeBatch(new CleanLogsClass_CF(ErrorLog_CF__c.class.toString()));
        Test.stopTest();
        System.assertEquals(0, database.countquery('SELECT COUNT() FROM ' + ErrorLog_CF__c.class.toString()), 'Clean up process failed.');
    }
    
    /**
     * Method to test the Integration Logs Apex Job class.
     */
    @isTest
    static void testIntegrationLogsJobClass() {
        
        //Now we check the Integration Logs.
        System.assertEquals(1, database.countquery('SELECT COUNT() FROM ' + IntegrationDetail_CF__c.class.toString()), 'No error logs found.');
        Test.startTest();
        Database.executeBatch(new CleanLogsClass_CF(IntegrationDetail_CF__c.class.toString()));
        Test.stopTest();
        System.assertEquals(0, database.countquery('SELECT COUNT() FROM ' + IntegrationDetail_CF__c.class.toString()), 'Clean up process failed.');
    }
}