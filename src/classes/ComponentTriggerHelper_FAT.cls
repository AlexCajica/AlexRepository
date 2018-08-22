/**
 * This is a Helper class for ComponentTrigger_FAT
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class ComponentTriggerHelper_FAT {

    /**
     * This method rejects records if they are duplicated, across Projects.
     *
     * @param lstAttachments    List of Attachments.
     */
    public static void rejectDuplicatedRecords(List<Component_FAT__c> lstComponents) {
        Set<String> setRemainingExistingComponents = new Set<String>();
        Set<Id> setTriggerRecordIds = new Set<Id>();
        Map<String, Boolean> mapRejectedValues = new Map<String, Boolean>();
        Map<String, Integer> mapDuplicatedTriggerRecords = new Map<String, Integer>();
        
        //First we get all the prospect values and check duplicates inside the list.
        for(Component_FAT__c objComponent : lstComponents) {
            Integer intTotalOfOccurrences = mapDuplicatedTriggerRecords.get(objComponent.UniqueAPIName_FAT__c);
            if(intTotalOfOccurrences == null) {
                intTotalOfOccurrences = 0;
            }
            intTotalOfOccurrences++;
            if(intTotalOfOccurrences > 1) {
                mapRejectedValues.put(objComponent.UniqueAPIName_FAT__c, true);
            } else {
                mapRejectedValues.put(objComponent.UniqueAPIName_FAT__c, false);
            }
            mapDuplicatedTriggerRecords.put(objComponent.UniqueAPIName_FAT__c, intTotalOfOccurrences);
        }
        
        //Now, for the new records, we need to reject those that are duplicated on the Trigger records.
        for(Component_FAT__c objComponent : lstComponents) {
            if(mapRejectedValues.get(objComponent.UniqueAPIName_FAT__c)) {
                objComponent.addError(Label.ComponentTriggerHelper_FAT_RejectedComponent_FAT);
            } else {
                setRemainingExistingComponents.add(objComponent.UniqueAPIName_FAT__c);
            }
        }
        
        //Now, for the remaning components, we will check the for existing duplicates in the Database compared against the new records.
        for(Component_FAT__c objExistingComponent : [SELECT Id, UniqueAPIName_FAT__c FROM Component_FAT__c WHERE UniqueAPIName_FAT__c IN :setRemainingExistingComponents LIMIT 1000]) {
            for(Component_FAT__c objComponent : lstComponents) {
                if(objComponent.Id != null && !mapRejectedValues.get(objComponent.UniqueAPIName_FAT__c) && 
                        objExistingComponent.UniqueAPIName_FAT__c == objComponent.UniqueAPIName_FAT__c && objExistingComponent.Id != objComponent.Id) {
                    objComponent.addError(Label.ComponentTriggerHelper_FAT_RejectedComponent_FAT);
                }
            }
        }
    }
}