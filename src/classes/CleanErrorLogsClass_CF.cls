/**
 * Schedulable class which cleans Error Logs
 * <p /><p />
 * @author Raymundo Rodriguez Sansores
 */
global class CleanErrorLogsClass_CF implements Schedulable {
    
    /**
     * Starts the execution of the scheduled process.
     *
     * @param objSchedulableContext Schedulable context.
     */
    global void execute(SchedulableContext objSchedulableContext) {
        Database.executeBatch(new CleanLogsClass_CF(ErrorLog_CF__c.class.toString()));
    }
}