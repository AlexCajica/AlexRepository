/**
 * Test class for Static_VariablesClass_FAT.
 * <p /><p />
 * @author Alejandro Cajica.
 */
@isTest
public class StaticVariablesTest_FAT {

    /**
     * Initialize constants for System.assertNotEquals('', StaticVariablesClass_FAT.
     */
    static testmethod void initializeVariables() {
        
        //Repository Integration variables.
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_INFORMATION_URL, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_USER_NAME, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_USER_PASSWORD, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_ADD_BRANCH_URL, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_GET_TREES_URL, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_STRING_UNKNOWN_FILE_EXTENSION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_STRING_MASTER, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_MASTER_BRANCH_URL, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_SHA_COMPONENT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_REF_HEADS_URL, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_GET_BODY_BRANCH_NAME, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_COMMA_SHA_COMPONENT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_MESSAGE_BRANCH_CREATED_PART_1, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_MESSAGE_BRANCH_CREATED_PART_2, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_MESSAGE_BRANCH_NOT_CREATED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_COMPONENT_RECORD_TYPE, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_FEATURE_BRANCH_OBJECT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_METEDATA_TYPE_GET_GITHUB_INFORMATION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_METEDATA_TYPE_CREATE_NEW_BRANCH, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_METEDATA_TYPE_GET_BRANCH_INFORMATION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_RESPONSE_RESERVED_KEYWORD_OBJECT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_RESPONSE_RESERVED_KEYWORD_OBJECT_REPLACE, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_RESPONSE_FILE_STRING, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_CLOSE_SQUARE_BRACKET_CURLY_BRACKET, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_MASTER_BRANCH_NAME, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.REPOSITORY_ADD_BRANCH_ERROR_MESSAGE, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_REPOSITORY_CREATION_STATUS_IN_PROGRESS, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_REPOSITORY_CREATION_STATUS_CREATED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_REPOSITORY_CREATION_STATUS_NOT_CREATED, 'Variable is not returning any value');

        //Deployment Package variables.
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_OPEN_XML_PACKAGE_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_CLOSE_XML_PACKAGE_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_OPEN_TYPES_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_CLOSE_TYPES_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_OPEN_MEMBERS_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_CLOSE_MEMBERS_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_OPEN_NAME_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_CLOSE_NAME_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_ATTACHMENT_NAME, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_FILE_EXTENSION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_DOT_FILE_EXTENSION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_SUCCESS_MESSAGE_PART_1, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_SUCCESS_MESSAGE_PART_2, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_CREATION_FAILED_MESSAGE, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_OPEN_VERSION_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_CLOSE_VERSION_TAG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_NAME, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_PRE_DELETION_NAME, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_PACKAGE_POST_DELETION_NAME, 'Variable is not returning any value');

        //Deployment variables.
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_READY_FOR_DEPLOYMENT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_PARTIALLY_COMPLETED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_PRE_DEPLOYMENT_ORDER, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_POST_DEPLOYMENT_ORDER, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_PRE_DELETION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_POST_DELETION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_DEPLOYED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_REJECTED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_IS_DELETION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_IS_NOT_DELETION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_TASK_NAME, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_TASK_STATUS, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_TASK_PRIORITY, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_TASK_SECONDARY_MESSAGE, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_API_VERSION, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEPLOYMENT_BASE_URL, 'Variable is not returning any value');

        //Record Type Name variables.
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_FEATURE_BRANCH_USER_STORY, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_FEATURE_BRANCH_USER_STORY_IN_PROGRESS, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_FEATURE_BRANCH_USER_STORY_NOT_CREATED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_FEATURE_BRANCH_USER_STORY_CREATED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_FEATURE_BRANCH_BUG, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_FEATURE_BRANCH_BUG_IN_PROGRESS, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_FEATURE_BRANCH_BUG_CREATED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_FEATURE_BRANCH_BUG_NOT_CREATED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_MANUAL_STEP_DEVELOPMENT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_METADATA_DEVELOPMENT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_ACCEPTANCE_CRITERIA_USER_STORY, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_ACCEPTANCE_CRITERIA_USER_STORY_FROZEN, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_RECORD_TYPE_DEPLOYMENT_FROZEN, 'Variable is not returning any value');

        //Object Names.
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_OBJECT_FEATURE_BRANCH, 'Variable is not returning any value');

        //Continuation Status Code
        System.assertNotEquals(null, StaticVariablesClass_FAT.INTEGER_STATUS_CODE_200, 'Variable is not returning any value');
        System.assertNotEquals(null, StaticVariablesClass_FAT.INTEGER_STATUS_CODE_201, 'Variable is not returning any value');
        System.assertNotEquals(null, StaticVariablesClass_FAT.INTEGER_STATUS_CODE_202, 'Variable is not returning any value');

        //Miscellaneous variables.
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_COLON, 'Variable is not returning any value');
        System.assertEquals('', StaticVariablesClass_FAT.STRING_BLANK_SPACE, 'Variable is returning a value');
        System.assertEquals('', StaticVariablesClass_FAT.STRING_BLANK, 'Variable is returning a value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DOT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_SLASH, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_SYMBOL_DOUBLE_QUOTES, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_CLOSE_SQUARE_BRACKET, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_CLOSE_CURLY_BRACKET, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ELLIPSIS, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_DEFAULT_PICKLIST_VALUE, 'Variable is not returning any value');

        //Continuation variables.
        System.assertNotEquals('', StaticVariablesClass_FAT.CONTINUATION_HTTPREQUEST_GET_METHOD, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.CONTINUATION_HTTPREQUEST_POST_METHOD, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.CONTINUATION_HTTPREQUEST_HEADER_BASIC, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.CONTINUATION_HTTPREQUEST_HEADER_AUTHORIZATION, 'Variable is not returning any value');
        
        //Test Case Status variables.
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_PASSED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_FAILED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_BLOCKED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_NOT_COMPLETED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STATUS_NOT_STARTED, 'Variable is not returning any value');
       
        //Test Case Step Status variables.
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_PASSED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_FAILED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_BLOCKED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_NOT_COMPLETED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_TEST_CASE_STEP_STATUS_NOT_STARTED, 'Variable is not returning any value');
        
        //User Story and Acceptance Criteria triggers.
        System.assertNotEquals(null, StaticVariablesClass_FAT.BOOLEAN_ACCEPTANCE_CRITERIA_TRIGGER_IS_ACTIVE, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_CLARIFICATION_REQUIRED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_GROOMING, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_FOR_DEVELOPMENT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_DEVELOPMENT_IN_PROGRESS, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_WAITING_FOR_DEPLOYMENT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_READY_TO_BE_TESTED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_NOT_REQUIRED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_COMPLETED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_USER_STORY_STATUS_OPEN, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_CLARIFICATION_REQUIRED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_ACCEPTANCE_TEST, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_ENVISIONING, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_APPROVED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_IN_PROGRESS, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_FINISHED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_READY_TO_BE_TESTED, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_DEVELOPMENT_CORRECT, 'Variable is not returning any value');
        System.assertNotEquals('', StaticVariablesClass_FAT.STRING_ACCEPTANCE_CRITERIA_TRIGGER_ACCEPTANCE_CRITERIA_STATUS_NOT_REQUIRED, 'Variable is not returning any value');
    }
}