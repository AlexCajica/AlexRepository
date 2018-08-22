/**
 * This is a Helper class for AttachmentTrigger_FAT
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class AttachmentTriggerHelper_FAT {

    /**
     * This method sends email alerts to User Story and Acceptance Criteria owners, after attaching a file to those records.
     *
     * @param lstAttachments    List of Attachments.
     */
    public static void sendEmailAlertsAfterAttachingFile(List<Attachment> lstAttachments) {
        Schema.sObjectType objUserStoryType = Schema.UserStory_FAT__c.getSObjectType();
        Schema.sObjectType objAcceptanceCriteriaType = Schema.AcceptanceCriteria_FAT__c.getSObjectType();
        UserStory_FAT__c objUserStoryParentRecord = new UserStory_FAT__c();
        AcceptanceCriteria_FAT__c objAcceptanceCriteriaParentRecord = new AcceptanceCriteria_FAT__c();
        List<UserStory_FAT__c> lstUserStoryParentRecords = new List<UserStory_FAT__c>();
        List<AcceptanceCriteria_FAT__c> lstAcceptanceCriteriaParentRecords = new List<AcceptanceCriteria_FAT__c>();
        List<sObject> lstParentRecords = new List<sObject>();
        for(Attachment objAttachment : lstAttachments) {
            if(objAttachment.ParentId.getSObjectType() == objUserStoryType) {
                objUserStoryParentRecord = new UserStory_FAT__c();
                objUserStoryParentRecord.Id = objAttachment.ParentId;
                objUserStoryParentRecord.SendAttachmentEmailAlert_FAT__c = true;
                lstUserStoryParentRecords.add(objUserStoryParentRecord);
            } else if(objAttachment.ParentId.getSObjectType() == objAcceptanceCriteriaType) {
                objAcceptanceCriteriaParentRecord = new AcceptanceCriteria_FAT__c();
                objAcceptanceCriteriaParentRecord.Id = objAttachment.ParentId;
                objAcceptanceCriteriaParentRecord.SendAttachmentEmailAlert_FAT__c = true;
                lstAcceptanceCriteriaParentRecords.add(objAcceptanceCriteriaParentRecord);
            }
        }
        if(lstUserStoryParentRecords.size() > 0) {
            DMLOperationsClass_CF.updateRecords(lstUserStoryParentRecords);
        }
        if(lstAcceptanceCriteriaParentRecords.size() > 0) {
            DMLOperationsClass_CF.updateRecords(lstAcceptanceCriteriaParentRecords);
        }
    }
}