/**
 * Trigger to control operations on Attachments.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
trigger AttachmentTrigger_FAT on Attachment(after insert) {
	if(Trigger.isAfter) {
		if(Trigger.isInsert) {
			AttachmentTriggerHelper_FAT.sendEmailAlertsAfterAttachingFile(Trigger.new);
		}
	}
}