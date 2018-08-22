/**
 * Apex class to show manual steps on deployment page.
 * <p /><p />
 * @author Gabriel Coronel.
 */
public class DeploymentManualStepsWrapperClass_FAT {

    //Public variables.
    public String strManualStepURL {get; set;}
    public String strManualStep {get; set;}
    public String strRejectionReason {get; set;}
    public Boolean boolIsApproved {get; set;}
    public Id idFeatureBranchComponent;
    public Id idFeatureBranchOwner;
    public List<Attachment> lstFeatureBranchComponentAttachments {get; set;}
}