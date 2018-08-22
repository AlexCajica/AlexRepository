/**
 * Schedulable class which cleans Integration Logs
 * <p /><p />
 * @author Raymundo Rodriguez Sansores
 */
global class CleanIntegrationLogsClass_CF implements Schedulable {
    
    /**
     * Starts the execution of the scheduled process.
     *
     * @param objSchedulableContext Schedulable context.
     */
    global void execute(SchedulableContext objSchedulableContext) {
        Database.executeBatch(new CleanLogsClass_CF(IntegrationDetail_CF__c.class.toString()));
    }
}