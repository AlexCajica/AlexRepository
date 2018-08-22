/**
 * Batch class to clean up Log records.
 * <p /><p />
 * @author Raymundo Rodriguez Sansores
 */
global class CleanLogsClass_CF implements Database.Batchable<sObject> {

    //Private variables.
    global final String strObject;

    /**
     * Constructor of the class.
     *
     * @param strObject Name of the Object where the cleaning will be applied.
     */
    global CleanLogsClass_CF(String strObject){
        this.strObject = strObject;
    }

    /**
     * Starting point of the Batch process.
     *
     * @param objBatchableContext Batchable context.
     * @return Query Locator with the records found.
     */
    global Database.QueryLocator start(Database.BatchableContext objBatchableContext){
        String strQuery = 'SELECT Id FROM ' + strObject;
        return Database.getQueryLocator(strQuery);
    }

    /**
     * Executes the required operations over the found records.
     *
     * @param objBatchableContext Batchable context.
     * @param lstRecordsToBeDeleted List of records of the current batch.
     */
    global void execute(Database.BatchableContext objBatchableContext, List<sObject> lstRecordsToBeDeleted){
        delete lstRecordsToBeDeleted;
    }

    /**
     * Implemented method on finish.
     *
     * @param objBatchableContext Batchable context.
     */
    global void finish(Database.BatchableContext objBatchableContext){}
}