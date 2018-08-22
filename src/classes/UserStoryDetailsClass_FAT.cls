/**
 * Wrapper class to store the User Story and Acceptance Criteria details.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public class UserStoryDetailsClass_FAT {
    
    //Public variables.
    public Boolean boolHasClarificationRequired {get; set;}
    public Boolean boolIsBeingGroomed {get; set;}
    public Integer intNumberOfDevelopmentFinished {get; set;}
    public Integer intNumberOfDevelopmentInProgress {get; set;}
    public Integer intNumberOfApproved {get; set;}
    public Integer intNumberOfCompleted {get; set;}
    public Integer intNumberOfReadyToBeTested {get; set;}
    public Integer intTotalSize {get; set;}
    public UserStory_FAT__c objUserStory {get; set;}
    
    /**
     * Constructor of the class.
     */
    public UserStoryDetailsClass_FAT(UserStory_FAT__c objUserStory) {
        boolHasClarificationRequired = false;
        boolIsBeingGroomed = false;
        intNumberOfDevelopmentFinished = 0;
        intNumberOfDevelopmentInProgress = 0;
        intNumberOfApproved = 0;
        intNumberOfCompleted = 0;
        intNumberOfReadyToBeTested = 0;
        intTotalSize = 0;
        this.objUserStory = objUserStory;
    }
}