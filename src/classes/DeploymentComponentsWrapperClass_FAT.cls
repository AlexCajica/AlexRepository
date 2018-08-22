/**
 * Apex class to show manual stepts on deployment page.
 * <p /><p />
 * @author Gabriel Coronel.
 */
public class DeploymentComponentsWrapperClass_FAT {

    //Public variables.
    public String strComponentName {get; set;}
    public String strIsDeletion {get; set;}
    public String strRejectionReason {get; set;}
    public String strComponentType {get; set;}
    public Boolean boolIsApproved {get; set;}
    public String strFeatureBranchComponentName;
    public String strMetadataAction;
    public Id idFeatureBranchComponent;
    public Id idFeatureBranchOwner;
    public Id idComponent;
}