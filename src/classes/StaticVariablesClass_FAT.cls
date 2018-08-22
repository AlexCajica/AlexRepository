/**
 * Constants for the Fast Agile Tracker.
 * <p /><p />
 * @author Alberto Gomez
 */
public virtual class StaticVariablesClass_FAT {

    //Repository Integration variables.
    public static String REPOSITORY_INFORMATION_URL {get {return 'https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads';}}
    public static String REPOSITORY_USER_NAME {get {return 'gcoronel1';}}
    public static String REPOSITORY_USER_PASSWORD {get {return 'Ago.2017';}}
    public static String REPOSITORY_ADD_BRANCH_URL {get {return 'https://api.github.com/repos/gcoronel1/TestFAT/git/refs';}}
    public static String REPOSITORY_GET_TREES_URL {get {return 'https://api.github.com/repos/gcoronel1/TestFAT/git/trees/';}}
    public static String REPOSITORY_STRING_UNKNOWN_FILE_EXTENSION {get {return 'file';}}
    public static String REPOSITORY_STRING_MASTER {get {return 'master';}}
    public static String REPOSITORY_MASTER_BRANCH_URL {get {return 'refs/heads/master';}}
    public static String REPOSITORY_SHA_COMPONENT {get {return '"sha":"';}}
    public static String REPOSITORY_REF_HEADS_URL {get {return '{"ref": "refs/heads/';}}
    public static String REPOSITORY_GET_BODY_BRANCH_NAME {get {return 'ref=/';}}
    public static String REPOSITORY_COMMA_SHA_COMPONENT {get {return '","sha": "';}}
    public static String REPOSITORY_MESSAGE_BRANCH_CREATED_PART_1 {get {return 'The branch was created in the repository with ';}}
    public static String REPOSITORY_MESSAGE_BRANCH_CREATED_PART_2 {get {return ' name.';}}
    public static String REPOSITORY_MESSAGE_BRANCH_NOT_CREATED {get {return 'Please create branch in the repository.';}}
    public static String REPOSITORY_COMPONENT_RECORD_TYPE {get {return 'Component';}}
    public static String REPOSITORY_FEATURE_BRANCH_OBJECT {get {return 'FeatureBranchComponent_FAT__c';}}
    public static String REPOSITORY_METEDATA_TYPE_GET_GITHUB_INFORMATION {get {return 'GitHubInformation_FAT';}}
    public static String REPOSITORY_METEDATA_TYPE_CREATE_NEW_BRANCH {get {return 'GitHubAddNewBranch_FAT';}}
    public static String REPOSITORY_METEDATA_TYPE_GET_BRANCH_INFORMATION {get {return 'GitHubRequestCommit_FAT';}}
    public static String REPOSITORY_RESPONSE_RESERVED_KEYWORD_OBJECT {get {return '"object"';}}
    public static String REPOSITORY_RESPONSE_RESERVED_KEYWORD_OBJECT_REPLACE {get {return '"objectInformation"';}}
    public static String REPOSITORY_RESPONSE_FILE_STRING {get {return '"files": ';}}
    public static String REPOSITORY_CLOSE_SQUARE_BRACKET_CURLY_BRACKET {get {return ']}';}}
    public static String REPOSITORY_MASTER_BRANCH_NAME {get {return 'master';}}
    public static String REPOSITORY_ADD_BRANCH_ERROR_MESSAGE {get {return 'An error has occurred in the repository, please press the Save button to try again.';}}
    public static String STRING_REPOSITORY_CREATION_STATUS_IN_PROGRESS {get {return 'In Progress';}}
    public static String STRING_REPOSITORY_CREATION_STATUS_CREATED {get {return 'Created';}}
    public static String STRING_REPOSITORY_CREATION_STATUS_NOT_CREATED {get {return 'Not Created';}}

    //Deployment Package variables.
    public static String STRING_DEPLOYMENT_PACKAGE_OPEN_XML_PACKAGE_TAG {get {return '<?xml version="1.0" encoding="UTF-8"?>\n<Package xmlns="http://soap.sforce.com/2006/04/metadata">\n\n';}}
    public static String STRING_DEPLOYMENT_PACKAGE_CLOSE_XML_PACKAGE_TAG {get {return '\n</Package>';}}
    public static String STRING_DEPLOYMENT_PACKAGE_OPEN_TYPES_TAG {get {return '\t<types>\n';}}
    public static String STRING_DEPLOYMENT_PACKAGE_CLOSE_TYPES_TAG {get {return '\t</types>\n';}}
    public static String STRING_DEPLOYMENT_PACKAGE_OPEN_MEMBERS_TAG {get {return '\t\t<members>';}}
    public static String STRING_DEPLOYMENT_PACKAGE_CLOSE_MEMBERS_TAG {get {return '</members>\n';}}
    public static String STRING_DEPLOYMENT_PACKAGE_OPEN_NAME_TAG {get {return '\t\t<name>';}}
    public static String STRING_DEPLOYMENT_PACKAGE_CLOSE_NAME_TAG {get {return '</name>\n';}}
    public static String STRING_DEPLOYMENT_PACKAGE_OPEN_VERSION_TAG {get {return '<version>';}}
    public static String STRING_DEPLOYMENT_PACKAGE_CLOSE_VERSION_TAG {get {return '</version>';}}
    public static String STRING_DEPLOYMENT_PACKAGE_ATTACHMENT_NAME {get {return 'Deployment Package ';}}
    public static String STRING_DEPLOYMENT_PACKAGE_FILE_EXTENSION {get {return 'xml';}}
    public static String STRING_DEPLOYMENT_PACKAGE_DOT_FILE_EXTENSION {get {return '.xml';}}
    public static String STRING_DEPLOYMENT_PACKAGE_SUCCESS_MESSAGE_PART_1 {get {return 'Deployment Package Created Successfully. ';}}
    public static String STRING_DEPLOYMENT_PACKAGE_SUCCESS_MESSAGE_PART_2 {get {return 'components added';}}
    public static String STRING_DEPLOYMENT_PACKAGE_CREATION_FAILED_MESSAGE {get {return 'Deployment Package Creation Failed';}}
    public static String STRING_DEPLOYMENT_PACKAGE_NAME {get {return 'package';}}
    public static String STRING_DEPLOYMENT_PACKAGE_PRE_DELETION_NAME {get {return 'destructiveChangesPre';}}
    public static String STRING_DEPLOYMENT_PACKAGE_POST_DELETION_NAME {get {return 'destructiveChangesPost';}}

    //Deployment variables.
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_READY_FOR_DEPLOYMENT {get {return 'Ready For Deployment';}}
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_PARTIALLY_COMPLETED {get {return 'Partially Completed';}}
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_PRE_DEPLOYMENT_ORDER {get {return 'Pre-deployment';}}
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_POST_DEPLOYMENT_ORDER {get {return 'Post-deployment';}}
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_PRE_DELETION {get {return 'Pre-Deletion';}}
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_POST_DELETION {get {return 'Post-Deletion';}}
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_DEPLOYED {get {return 'Deployed';}}
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_REJECTED {get {return 'Rejected';}}
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_IS_DELETION {get {return 'Yes: ';}}
    public static String STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_IS_NOT_DELETION {get {return 'No';}}
    public static String STRING_DEPLOYMENT_TASK_NAME {get {return 'Feedback';}}
    public static String STRING_DEPLOYMENT_TASK_STATUS {get {return 'Not Started';}}
    public static String STRING_DEPLOYMENT_TASK_PRIORITY {get {return 'High';}}
    public static String STRING_DEPLOYMENT_TASK_SECONDARY_MESSAGE {get {return 'This FBC was rejected because of ';}}
    public static String STRING_DEPLOYMENT_API_VERSION {get {return '41.0';}}
    public static String STRING_DEPLOYMENT_BASE_URL {get {return 'https://cs17.salesforce.com/';}}

    //Record Type Name variables.
    public static String STRING_RECORD_TYPE_FEATURE_BRANCH_USER_STORY {get {return 'User Story';}}
    public static String STRING_RECORD_TYPE_FEATURE_BRANCH_USER_STORY_IN_PROGRESS {get {return 'User Story In Progress';}}
    public static String STRING_RECORD_TYPE_FEATURE_BRANCH_USER_STORY_NOT_CREATED {get {return 'User Story Not Created';}}
    public static String STRING_RECORD_TYPE_FEATURE_BRANCH_USER_STORY_CREATED {get {return 'User Story Created';}}
    public static String STRING_RECORD_TYPE_FEATURE_BRANCH_BUG {get {return 'Bug';}}
    public static String STRING_RECORD_TYPE_FEATURE_BRANCH_BUG_IN_PROGRESS {get {return 'Bug In Progress';}}
    public static String STRING_RECORD_TYPE_FEATURE_BRANCH_BUG_CREATED {get {return 'Bug Created';}}
    public static String STRING_RECORD_TYPE_FEATURE_BRANCH_BUG_NOT_CREATED {get {return 'Bug Not Created';}}
    public static String STRING_RECORD_TYPE_MANUAL_STEP_DEVELOPMENT {get {return 'Manual Step Development';}}
    public static String STRING_RECORD_TYPE_METADATA_DEVELOPMENT {get {return 'Metadata Development';}}
    public static String STRING_RECORD_TYPE_ACCEPTANCE_CRITERIA_USER_STORY {get {return 'User Story';}}
    public static String STRING_RECORD_TYPE_ACCEPTANCE_CRITERIA_USER_STORY_FROZEN {get {return 'User Story Frozen';}}
    public static String STRING_RECORD_TYPE_DEPLOYMENT_FROZEN {get {return 'Deployment Frozen';}}

    //Object Names.
    public static String STRING_OBJECT_FEATURE_BRANCH {get {return 'FeatureBranch_FAT__c';}}

    //Continuation Status Code
    public static Integer INTEGER_STATUS_CODE_200 {get {return 200;}}
    public static Integer INTEGER_STATUS_CODE_201 {get {return 201;}}
    public static Integer INTEGER_STATUS_CODE_202 {get {return 202;}}

    //Miscellaneous variables.
    public static String STRING_COLON {get {return ':';}}
    public static String STRING_BLANK_SPACE {get {return '';}}
    public static String STRING_BLANK {get {return '';}}
    public static String STRING_DOT {get {return '.';}}
    public static String STRING_SLASH {get {return '/';}}
    public static String STRING_SYMBOL_DOUBLE_QUOTES {get {return '"';}}
    public static String STRING_CLOSE_SQUARE_BRACKET {get {return ']';}}
    public static String STRING_CLOSE_CURLY_BRACKET {get {return '}';}}
    public static String STRING_ELLIPSIS {get {return '...';}}
    public static String STRING_DEFAULT_PICKLIST_VALUE {get {return '-- None --';}}

    //Continuation variables.
    public static String CONTINUATION_HTTPREQUEST_GET_METHOD {get {return 'GET';}}
    public static String CONTINUATION_HTTPREQUEST_POST_METHOD {get {return 'POST';}}
    public static String CONTINUATION_HTTPREQUEST_HEADER_BASIC {get {return 'BASIC ';}}
    public static String CONTINUATION_HTTPREQUEST_HEADER_AUTHORIZATION {get {return 'Authorization';}}
    
    //Test Case Status variables.
    public static String STRING_TEST_CASE_STATUS_PASSED {get {return 'Passed';}}
    public static String STRING_TEST_CASE_STATUS_FAILED {get {return 'Failed';}}
    public static String STRING_TEST_CASE_STATUS_BLOCKED {get {return 'Blocked';}}
    public static String STRING_TEST_CASE_STATUS_NOT_COMPLETED {get {return 'Not Completed';}}
    public static String STRING_TEST_CASE_STATUS_NOT_STARTED {get {return 'Not Started';}}
   
     //Test Case Step Status variables.
    public static String STRING_TEST_CASE_STEP_STATUS_PASSED {get {return 'Passed';}}
    public static String STRING_TEST_CASE_STEP_STATUS_FAILED {get {return 'Failed';}}
    public static String STRING_TEST_CASE_STEP_STATUS_BLOCKED {get {return 'Blocked';}}
    public static String STRING_TEST_CASE_STEP_STATUS_NOT_COMPLETED {get {return 'Not Completed';}}
    public static String STRING_TEST_CASE_STEP_STATUS_NOT_STARTED {get {return 'Not Started';}}
    
    //User Story and Acceptance Criteria triggers.
    public static Boolean BOOLEAN_ACCEPTANCE_CRITERIA_TRIGGER_IS_ACTIVE {
        get{ 
            if(BOOLEAN_ACCEPTANCE_CRITERIA_TRIGGER_IS_ACTIVE == null) {
                BOOLEAN_ACCEPTANCE_CRITERIA_TRIGGER_IS_ACTIVE = true;
            }
            return BOOLEAN_ACCEPTANCE_CRITERIA_TRIGGER_IS_ACTIVE;
        } 
        set;
    }
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_CLARIFICATION_REQUIRED {get {return 'Clarification Required';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_GROOMING {get {return 'Grooming';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_FOR_DEVELOPMENT {get {return 'Ready for Development';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_DEVELOPMENT_IN_PROGRESS {get {return 'Development In Progress';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_WAITING_FOR_DEPLOYMENT {get {return 'Waiting for Deployment';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_TO_BE_TESTED {get {return 'Ready to be Tested';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_NOT_REQUIRED {get {return 'Not Required';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_COMPLETED {get {return 'Completed';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_OPEN {get {return 'Open';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_CLARIFICATION_REQUIRED {get {return 'Clarification Required';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_ACCEPTANCE_TEST {get {return 'Acceptance Test';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_ENVISIONING {get {return 'Envisioning';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_APPROVED {get {return 'Approved';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_IN_PROGRESS {get {return 'Development In Progress';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_FINISHED {get {return 'Development Finished';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_READY_TO_BE_TESTED {get {return 'Ready to be Tested';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_CORRECT {get {return 'Development meets acceptance criteria';}}
    public static String STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_NOT_REQUIRED {get {return 'Not Required';}}
}