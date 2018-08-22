/**
 * This is a Helper class for SprintTrigger_FAT
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class SprintTriggerHelper_FAT {

    /**
     * This method rejects records if they are duplicated, across Projects.
     *
     * @param lstAttachments    List of Attachments.
     */
    public static void rejectDuplicatedRecords(List<Sprint_FAT__c> lstSprints) {
        Set<String> setRemainingExistingSprints = new Set<String>();
        Set<Id> setTriggerRecordIds = new Set<Id>();
        Map<String, Boolean> mapRejectedValues = new Map<String, Boolean>();
        Map<String, Integer> mapDuplicatedTriggerRecords = new Map<String, Integer>();
        
        //First we get all the prospect values and check duplicates inside the list.
        for(Sprint_FAT__c objSprint : lstSprints) {
            Integer intTotalOfOccurrences = mapDuplicatedTriggerRecords.get(objSprint.UniqueAPIName_FAT__c);
            if(intTotalOfOccurrences == null) {
                intTotalOfOccurrences = 0;
            }
            intTotalOfOccurrences++;
            if(intTotalOfOccurrences > 1) {
                mapRejectedValues.put(objSprint.UniqueAPIName_FAT__c, true);
            } else {
                mapRejectedValues.put(objSprint.UniqueAPIName_FAT__c, false);
            }
            mapDuplicatedTriggerRecords.put(objSprint.UniqueAPIName_FAT__c, intTotalOfOccurrences);
        }
        
        //Now, for the new records, we need to reject those that are duplicated on the Trigger records.
        for(Sprint_FAT__c objSprint : lstSprints) {
            if(mapRejectedValues.get(objSprint.UniqueAPIName_FAT__c)) {
                objSprint.addError(Label.SprintTriggerHelper_FAT_RejectedSprint_FAT);
            } else {
                setRemainingExistingSprints.add(objSprint.UniqueAPIName_FAT__c);
            }
        }
        
        //Now, for the remaning Sprints, we will check the for existing duplicates in the Database compared against the new records.
        for(Sprint_FAT__c objExistingSprint : [SELECT Id, UniqueAPIName_FAT__c FROM Sprint_FAT__c WHERE UniqueAPIName_FAT__c IN :setRemainingExistingSprints LIMIT 1000]) {
            for(Sprint_FAT__c objSprint : lstSprints) {
                if(objSprint.Id != null && !mapRejectedValues.get(objSprint.UniqueAPIName_FAT__c) && 
                        objExistingSprint.UniqueAPIName_FAT__c == objSprint.UniqueAPIName_FAT__c && objExistingSprint.Id != objSprint.Id) {
                    objSprint.addError(Label.SprintTriggerHelper_FAT_RejectedSprint_FAT);
                }
            }
        }
    }
}