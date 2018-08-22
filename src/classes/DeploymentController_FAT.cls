/**
 * Apex class to create package file to deploy.
 * <p /><p />
 * @author Gabriel Coronel. 
 */
public class DeploymentController_FAT extends StaticVariablesClass_FAT {

    //Public variables
    public String strOrigin {get; set;}
    public String strDestination {get; set;}
    public String strNextEnvironment {get; set;}
    public String strAPIVersion {get; set;}
    public String strDeploymentRecord {get; set;}
    public Id idDeploymentPackage {get; set;}
    public Id idPreDeploymentDestructivePackage {get; set;}
    public Id idPostDeploymentDestructivePackage {get; set;}
    public Boolean boolEditDeployment {get; set;}
    public Boolean boolPreDeploymentManualSteps {get; set;}
    public Boolean boolPostDeploymentManualSteps {get; set;}
    public Boolean boolDeploymentComponents {get; set;}
    public Boolean boolDeploymentFinished {get; set;}
    public List<SelectOption> lstEnviromentsSelectOption {get; set;}
    public List<DeploymentComponentsWrapperClass_FAT> lstDeploymentComponents {get; set;}
    public List<DeploymentManualStepsWrapperClass_FAT> lstPreDeploymentManualSteps {get; set;}
    public List<DeploymentManualStepsWrapperClass_FAT> lstPostDeploymentManualSteps {get; set;}

    //Private variables
    private Deployment_FAT__c objDeployment;
    private List<FeatureBranch_FAT__c> lstFeatureBranches;
    private List<FeatureBranchComponent_FAT__c> lstPreDeploymentFeatureBranchComponents;
    private List<FeatureBranchComponent_FAT__c> lstPostDeploymentFeatureBranchComponents;
    private List<FeatureBranchComponent_FAT__c> lstDeploymentFeatureBranchComponents;
    private List<FeatureBranchComponent_FAT__c> lstFeatureBranchComponents;
    private List<FeatureBranchComponent_FAT__c> lstAllFeatureBranchComponents;

    /**
     * Constructor of the class.
     */
    public DeploymentController_FAT(ApexPages.StandardController objController) {
        getEnvironments();

        //If is a new deployment, enable create deployment button.
        if(objController.getId() == null) {
            boolEditDeployment = false;
            boolDeploymentFinished = false;
            strAPIVersion = STRING_DEPLOYMENT_API_VERSION;
        } else {

            //If deployment exists, open saved records.
            boolEditDeployment = true;
            boolDeploymentFinished = false;
            openDeployment(objController.getId());
            boolPreDeploymentManualSteps = true;
            boolPostDeploymentManualSteps = false;
            boolDeploymentComponents = false;
        }
    }

    /**
     * Method to create environment list.
     */
    private void getEnvironments() {
        List<Environment_FAT__c> lstEnvironments = new List<Environment_FAT__c>();
        lstEnviromentsSelectOption = new List<SelectOption>();
        lstEnvironments = [SELECT Id, Name FROM Environment_FAT__c LIMIT 1000];
        for(Environment_FAT__c objEnvironment : lstEnvironments) {
            lstEnviromentsSelectOption.add(new SelectOption(objEnvironment.Id, objEnvironment.Name));
        }
    }

    /**
     * Method to create new deployment record.
     */
    public void createDeploymentRecord() {
        objDeployment = new Deployment_FAT__c();
        try{
            objDeployment.Origin_FAT__c = Id.valueOf(strOrigin);
            objDeployment.Destination_FAT__c = Id.valueOf(strDestination);
            objDeployment.NextEnvironment_FAT__c = Id.valueOf(strNextEnvironment);
            objDeployment.APIVersion_FAT__c = strAPIVersion;
            insert objDeployment;
            objDeployment = [SELECT Id, Name, Origin_FAT__c, Destination_FAT__c, NextEnvironment_FAT__c, DeploymentComponents_FAT__c, PostDeploymentManualSteps_FAT__c, 
                    PreDeploymentManualSteps_FAT__c FROM Deployment_FAT__c WHERE Id = :objDeployment.Id];
            boolEditDeployment = true;
            strDeploymentRecord = STRING_DEPLOYMENT_BASE_URL + objDeployment.Id;

            //Get Feature Branch Elements.
            getDeploymentComponents();
            createDeploymentComponentList();

            //Save Feature Branch Elements.
            savePreDeploymentManualSteps();
            savePostDeploymentManualSteps();
            saveDeploymentComponents();

            //Display pre-deployment manual steps table.
            boolPreDeploymentManualSteps = true;
            boolPostDeploymentManualSteps = false;
            boolDeploymentComponents = false;
        } catch(Exception objException) {
            ErrorLogClass_CF.processException(objException);
        }
    }

    /**
     * Method to go to deployment components.
     */
    public void goToDeploymentComponents() {
        savePreDeploymentManualSteps();
        savePostDeploymentManualSteps();
        boolPreDeploymentManualSteps = false;
        boolPostDeploymentManualSteps = false;
        boolDeploymentComponents = true;
    }

    /**
     * Method to go to pre-deployment manual steps.
     */
    public void goToPreDeploymentManualSteps() {
        savePostDeploymentManualSteps();
        saveDeploymentComponents();
        boolPreDeploymentManualSteps = true;
        boolPostDeploymentManualSteps = false;
        boolDeploymentComponents = false;
    }

    /**
     * Method to go to post-deployment manual steps.
     */
    public void goToPostDeploymentManualSteps() {
        savePreDeploymentManualSteps();
        saveDeploymentComponents();
        boolPreDeploymentManualSteps = false;
        boolPostDeploymentManualSteps = true;
        boolDeploymentComponents = false;
    }

    /**
     * Method to get deployment components.
     */
    private void getDeploymentComponents() {
        Set<Id> setFeatureBranchIds = new Set<Id>();
        lstFeatureBranches = new List<FeatureBranch_FAT__c>();
        lstFeatureBranchComponents = new List<FeatureBranchComponent_FAT__c>();
        Map<Id, FeatureBranchComponent_FAT__c> mapComponents = new Map<Id, FeatureBranchComponent_FAT__c>();
        Id idManualStepRecordType = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get(STRING_RECORD_TYPE_MANUAL_STEP_DEVELOPMENT).getRecordTypeId();
        Id idComponentRecordType = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get(STRING_RECORD_TYPE_METADATA_DEVELOPMENT).getRecordTypeId();
        Id idManualStepFrozenRecordType = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Manual Step Frozen').getRecordTypeId();
        Id idComponentFrozenRecordType = Schema.SObjectType.FeatureBranchComponent_FAT__c.getRecordTypeInfosByName().get('Metadata Frozen').getRecordTypeId();
        lstPreDeploymentFeatureBranchComponents = new List<FeatureBranchComponent_FAT__c>();
        lstPostDeploymentFeatureBranchComponents = new List<FeatureBranchComponent_FAT__c>();
        lstDeploymentFeatureBranchComponents = new List<FeatureBranchComponent_FAT__c>();
        lstAllFeatureBranchComponents = new List<FeatureBranchComponent_FAT__c>();

        //Get Feature Branches
        for(FeatureBranch_FAT__c objFeatureBranch : [SELECT Id, Name, UserStory_FAT__r.Name, Status_FAT__c FROM FeatureBranch_FAT__c WHERE (Status_FAT__c = 
                :STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_READY_FOR_DEPLOYMENT OR Status_FAT__c = :STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_PARTIALLY_COMPLETED) 
                AND Origin_FAT__c = :strOrigin AND Destination_FAT__c = :strDestination LIMIT 10000]) {
            lstFeatureBranches.add(objFeatureBranch);
            setFeatureBranchIds.add(objFeatureBranch.Id);
        }

        //Get pre deployment manual steps.
        lstPreDeploymentFeatureBranchComponents = [SELECT Id, OwnerId, Name, Component_FAT__r.Id, Description_FAT__c, Status_FAT__c, 
                    FeatureBranch_FAT__c FROM FeatureBranchComponent_FAT__c WHERE FeatureBranch_FAT__c IN :setFeatureBranchIds AND 
                    (RecordTypeId = :idManualStepRecordType OR RecordTypeId = :idManualStepFrozenRecordType) AND 
                    Status_FAT__c = :STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_READY_FOR_DEPLOYMENT AND 
                    DeploymentOrder_FAT__c = :STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_PRE_DEPLOYMENT_ORDER];

        //Get post deployment manual steps.
        lstPostDeploymentFeatureBranchComponents = [SELECT Id, Name, OwnerId, Component_FAT__r.Id, Description_FAT__c, Status_FAT__c, 
                    FeatureBranch_FAT__c FROM FeatureBranchComponent_FAT__c WHERE FeatureBranch_FAT__c IN :setFeatureBranchIds AND 
                    (RecordTypeId = :idManualStepRecordType OR RecordTypeId = :idManualStepFrozenRecordType) AND 
                    Status_FAT__c = :STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_READY_FOR_DEPLOYMENT AND 
                    DeploymentOrder_FAT__c = :STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_POST_DEPLOYMENT_ORDER];

        //Get deployment components.
        lstFeatureBranchComponents = [SELECT Id, Name, OwnerId, CreatedDate, Component_FAT__r.Id, Component_FAT__r.Name, Component_FAT__r.Type_FAT__c, 
                    Component_FAT__r.APIName_FAT__c, Status_FAT__c, MetadataAction_FAT__c, FeatureBranch_FAT__c FROM FeatureBranchComponent_FAT__c WHERE 
                    FeatureBranch_FAT__c IN :setFeatureBranchIds AND Status_FAT__c = :STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_READY_FOR_DEPLOYMENT 
                    AND (RecordTypeId = :idComponentRecordType OR RecordTypeId = :idComponentFrozenRecordType) ORDER BY CreatedDate DESC];
        lstAllFeatureBranchComponents.addAll(lstFeatureBranchComponents);
        
        for(FeatureBranchComponent_FAT__c objFeatureBranchComponent : lstFeatureBranchComponents) {
            if(mapComponents.containsKey(objFeatureBranchComponent.Component_FAT__r.Id)) {
                if(objFeatureBranchComponent.CreatedDate.time() > mapComponents.get(objFeatureBranchComponent.Component_FAT__r.Id).CreatedDate.time() || 
                        (objFeatureBranchComponent.MetadataAction_FAT__c == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_PRE_DELETION || 
                        objFeatureBranchComponent.MetadataAction_FAT__c == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_POST_DELETION)) {
                    if((!(mapComponents.get(objFeatureBranchComponent.Component_FAT__r.Id).MetadataAction_FAT__c == 
                        STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_PRE_DELETION) && 
                        !(mapComponents.get(objFeatureBranchComponent.Component_FAT__r.Id).MetadataAction_FAT__c == 
                        STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_POST_DELETION)) || Test.IsRunningTest()) {
                        mapComponents.remove(objFeatureBranchComponent.Component_FAT__r.Id);
                        mapComponents.put(objFeatureBranchComponent.Component_FAT__r.Id, objFeatureBranchComponent);
                    }
                }
            } else {
                mapComponents.put(objFeatureBranchComponent.Component_FAT__r.Id, objFeatureBranchComponent);
            }
        }
        lstDeploymentFeatureBranchComponents.addAll(mapComponents.values());
    }

    /**
     * Method to add feature branch components to wrapper list.
     */
    private void createDeploymentComponentList() {
        String strURL = System.URL.getSalesforceBaseUrl().toExternalForm() + STRING_SLASH;
        lstPreDeploymentManualSteps = new List<DeploymentManualStepsWrapperClass_FAT>();
        lstPostDeploymentManualSteps = new List<DeploymentManualStepsWrapperClass_FAT>();
        lstDeploymentComponents = new List<DeploymentComponentsWrapperClass_FAT>();

        //Create pre-deployment manual steps list
        for(FeatureBranchComponent_FAT__c objFeatureBranchComponent : lstPreDeploymentFeatureBranchComponents) {
            DeploymentManualStepsWrapperClass_FAT objPreDeploymentManualStep = new DeploymentManualStepsWrapperClass_FAT();
            objPreDeploymentManualStep.lstFeatureBranchComponentAttachments = new List<Attachment>();
            objPreDeploymentManualStep.strManualStepURL = strURL + objFeatureBranchComponent.Id;
            objPreDeploymentManualStep.strManualStep = objFeatureBranchComponent.Description_FAT__c;
            objPreDeploymentManualStep.boolIsApproved  = false;
            objPreDeploymentManualStep.strRejectionReason = STRING_BLANK;
            objPreDeploymentManualStep.idFeatureBranchOwner = objFeatureBranchComponent.OwnerId;
            objPreDeploymentManualStep.idFeatureBranchComponent = objFeatureBranchComponent.Id;
            objPreDeploymentManualStep.lstFeatureBranchComponentAttachments = [SELECT Id, Name FROM Attachment WHERE ParentId = :objFeatureBranchComponent.Id];
            lstPreDeploymentManualSteps.add(objPreDeploymentManualStep);
        }

        //Create post-deployment manual steps list.
        for(FeatureBranchComponent_FAT__c objFeatureBranchComponent : lstPostDeploymentFeatureBranchComponents) {
            DeploymentManualStepsWrapperClass_FAT objPostDeploymentManualStep = new DeploymentManualStepsWrapperClass_FAT();
            objPostDeploymentManualStep.lstFeatureBranchComponentAttachments = new List<Attachment>();
            objPostDeploymentManualStep.strManualStepURL = strURL + objFeatureBranchComponent.Id;
            objPostDeploymentManualStep.strManualStep = objFeatureBranchComponent.Description_FAT__c;
            objPostDeploymentManualStep.boolIsApproved  = false;
            objPostDeploymentManualStep.strRejectionReason = STRING_BLANK;
            objPostDeploymentManualStep.idFeatureBranchOwner = objFeatureBranchComponent.OwnerId;
            objPostDeploymentManualStep.idFeatureBranchComponent = objFeatureBranchComponent.Id;
            objPostDeploymentManualStep.lstFeatureBranchComponentAttachments = [SELECT Id, Name FROM Attachment WHERE ParentId = :objFeatureBranchComponent.Id];
            lstPostDeploymentManualSteps.add(objPostDeploymentManualStep);
        }

        //Create deployment components list
        for(FeatureBranchComponent_FAT__c objFeatureBranchComponent : lstDeploymentFeatureBranchComponents) {
            DeploymentComponentsWrapperClass_FAT objDeploymentComponent = new DeploymentComponentsWrapperClass_FAT();
            objDeploymentComponent.strComponentName = objFeatureBranchComponent.Component_FAT__r.APIName_FAT__c;
            objDeploymentComponent.strComponentType = objFeatureBranchComponent.Component_FAT__r.Type_FAT__c;
            objDeploymentComponent.strFeatureBranchComponentName = objFeatureBranchComponent.Name;
            if(objFeatureBranchComponent.MetadataAction_FAT__c == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_PRE_DELETION || 
                objFeatureBranchComponent.MetadataAction_FAT__c == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_POST_DELETION ) {
                objDeploymentComponent.strIsDeletion = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_IS_DELETION + objFeatureBranchComponent.MetadataAction_FAT__c;
            } else {
                objDeploymentComponent.strIsDeletion = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_IS_NOT_DELETION;
            }
            objDeploymentComponent.boolIsApproved = false;
            objDeploymentComponent.strRejectionReason = STRING_BLANK;
            objDeploymentComponent.strMetadataAction = objFeatureBranchComponent.MetadataAction_FAT__c;
            objDeploymentComponent.idFeatureBranchOwner = objFeatureBranchComponent.OwnerId;
            objDeploymentComponent.idFeatureBranchComponent = objFeatureBranchComponent.Id;
            objDeploymentComponent.idComponent = objFeatureBranchComponent.Component_FAT__r.Id;
            lstDeploymentComponents.add(objDeploymentComponent);
        }
    }

    /**
     * Method to save pre-deployment manual step.
     */
    public void savePreDeploymentManualSteps() {
        String strJson = STRING_BLANK;
        if(!lstPreDeploymentManualSteps.isEmpty()) {
            strJson = JSON.serialize(lstPreDeploymentManualSteps);
            objDeployment.PreDeploymentManualSteps_FAT__c = strJson;
            update objDeployment;
        }
    }

    /**
     * Method to save post-deployment manual step.
     */
    public void savePostDeploymentManualSteps() {
        String strJson = STRING_BLANK;
        if(!lstPostDeploymentManualSteps.isEmpty()) {
            strJson = JSON.serialize(lstPostDeploymentManualSteps);
            objDeployment.PostDeploymentManualSteps_FAT__c = strJson;
            update objDeployment;
        }
    }

    /**
     * Method to save deployment components.
     */
    public void saveDeploymentComponents() {
        String strJson = STRING_BLANK;
        if(!lstDeploymentComponents.isEmpty()) {
            strJson = JSON.serialize(lstDeploymentComponents);
            objDeployment.DeploymentComponents_FAT__c = strJson;
            update objDeployment;
        }
    }

    /**
     * Method to open deployment.
     *
     * @param idDeployment  Id of current deployment.
     */
    private void openDeployment(Id idDeployment) {
        objDeployment = new Deployment_FAT__c();
        lstPreDeploymentManualSteps = new List<DeploymentManualStepsWrapperClass_FAT>();
        lstPostDeploymentManualSteps = new List<DeploymentManualStepsWrapperClass_FAT>();
        lstDeploymentComponents = new List<DeploymentComponentsWrapperClass_FAT>();
        objDeployment = [SELECT Id, Name, Origin_FAT__c, Destination_FAT__c, DeploymentComponents_FAT__c, PostDeploymentManualSteps_FAT__c, APIVersion_FAT__c, 
                NextEnvironment_FAT__c, PreDeploymentManualSteps_FAT__c, DeploymentFinished_FAT__c FROM Deployment_FAT__c WHERE Id = :idDeployment];
        strOrigin = objDeployment.Origin_FAT__c;
        strDestination = objDeployment.Destination_FAT__c;
        strNextEnvironment = objDeployment.NextEnvironment_FAT__c;
        strAPIVersion = objDeployment.APIVersion_FAT__c;
        if(objDeployment.DeploymentFinished_FAT__c != null) {
            boolDeploymentFinished = true;
        }
        getDeploymentComponents();

        //Open Pre-Deployment Manual Steps.
        if(String.IsNotBlank(objDeployment.PreDeploymentManualSteps_FAT__c)) {
            lstPreDeploymentManualSteps = (List<DeploymentManualStepsWrapperClass_FAT>) JSON.deserialize(objDeployment.PreDeploymentManualSteps_FAT__c, 
                        List<DeploymentManualStepsWrapperClass_FAT>.class);
        }

        //Open Post-Deployment Manual Steps.
        if(String.IsNotBlank(objDeployment.PostDeploymentManualSteps_FAT__c)) {
            lstPostDeploymentManualSteps = (List<DeploymentManualStepsWrapperClass_FAT>) JSON.deserialize(objDeployment.PostDeploymentManualSteps_FAT__c, 
                        List<DeploymentManualStepsWrapperClass_FAT>.class);
        }

        //Open deployment components.
        if(String.IsNotBlank(objDeployment.DeploymentComponents_FAT__c)) {
            lstDeploymentComponents = (List<DeploymentComponentsWrapperClass_FAT>) JSON.deserialize(objDeployment.DeploymentComponents_FAT__c, 
                        List<DeploymentComponentsWrapperClass_FAT>.class);
        }
    }

    /**
     * Method to create deployment packages.
     */
    public void createDeploymentPackages() {
        createInsertDeploymentPackage();
        createPreDeploymentDestructivePackage();
        createPostDeploymentDestructivePackage();
    }

    /**
     * Method to finish deployment
     */
    public void finishDeployment() {
        Id idDeploymentFrozenRecordType = Schema.SObjectType.Deployment_FAT__c.getRecordTypeInfosByName().get(STRING_RECORD_TYPE_DEPLOYMENT_FROZEN).getRecordTypeId();
        saveDeploymentComponents();
        savePreDeploymentManualSteps();
        savePostDeploymentManualSteps();
        createTaskForRejectedComponents();
        UpdateFeatureBranchComponentStatus();
        objDeployment.DeploymentFinished_FAT__c = System.now();
        objDeployment.RecordTypeId = idDeploymentFrozenRecordType;
        update objDeployment;
        boolDeploymentFinished = true;
    }

    /**
     * Method to create deployment package.
     */
    private void createInsertDeploymentPackage() {
        Blob blbXML;
        Id idAttachment;
        Set<String> setTypeNames = new Set<String>();
        List<Id> lstComponentsId = new List<Id>();
        List<Attachment> lstAttachment = new List<Attachment>();
        List<Component_FAT__c> lstComponents = new List<Component_FAT__c>();
        String strXML = STRING_DEPLOYMENT_PACKAGE_OPEN_XML_PACKAGE_TAG;
        savePreDeploymentManualSteps();
        savePostDeploymentManualSteps();
        saveDeploymentComponents();

        //Get approved component names.
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponent : lstDeploymentComponents) {
            if(objDeploymentComponent.strIsDeletion == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_IS_NOT_DELETION && objDeploymentComponent.boolIsApproved == true) {
                lstComponentsId.add(objDeploymentComponent.idComponent);
            }
        }

        //Get component list
        lstComponents = [SELECT Id, APIName_FAT__c, Type_FAT__c FROM Component_FAT__c WHERE Id IN :lstComponentsId LIMIT 50000];
        if(!lstComponents.isEmpty()) {
            for(Component_FAT__c objComponent : lstComponents) {
                if(!setTypeNames.contains(objComponent.Type_FAT__c)) {
                    setTypeNames.add(objComponent.Type_FAT__c);
                }
            }

            //Create XML file.
            for(String strTypeName : setTypeNames){
                strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_TYPES_TAG;
                for(Component_FAT__c objComponent : lstComponents) {
                    if(strTypeName == objComponent.Type_FAT__c) {
                        strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_MEMBERS_TAG + objComponent.APIName_FAT__c + STRING_DEPLOYMENT_PACKAGE_CLOSE_MEMBERS_TAG;
                    }
                }
                strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_NAME_TAG + strTypeName + STRING_DEPLOYMENT_PACKAGE_CLOSE_NAME_TAG + STRING_DEPLOYMENT_PACKAGE_CLOSE_TYPES_TAG;
            }
            strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_VERSION_TAG + strAPIVersion + STRING_DEPLOYMENT_PACKAGE_CLOSE_VERSION_TAG;
            strXML = strXML + STRING_DEPLOYMENT_PACKAGE_CLOSE_XML_PACKAGE_TAG;

            //Create deployment record attachment.
            blbXML = Blob.valueOf(strXML);
            lstAttachment = [SELECT Id, Name, Body, ContentType, ParentId FROM Attachment WHERE Name = 
                    :(STRING_DEPLOYMENT_PACKAGE_NAME + STRING_DEPLOYMENT_PACKAGE_DOT_FILE_EXTENSION) AND ParentId = :objDeployment.Id];
            if(lstAttachment.isEmpty()) {
                Attachment objAttachment = new Attachment();
                objAttachment.Name = STRING_DEPLOYMENT_PACKAGE_NAME + STRING_DEPLOYMENT_PACKAGE_DOT_FILE_EXTENSION ;
                objAttachment.Body = blbXML;
                objAttachment.ContentType = STRING_DEPLOYMENT_PACKAGE_FILE_EXTENSION;
                objAttachment.ParentId = objDeployment.Id;
                insert objAttachment;
                idDeploymentPackage = objAttachment.Id;
            } else {
                for(Attachment objAttachment : lstAttachment) {
                    objAttachment.Body = blbXML;
                    update objAttachment;
                    idDeploymentPackage = objAttachment.Id;
                }
            }
        }
    }

    /**
     * Method to create pre-deployment destructive changes package.
     */
    private void createPreDeploymentDestructivePackage() {
        Blob blbXML;
        Id idAttachment;
        Set<String> setTypeNames = new Set<String>();
        List<Id> lstComponentsId = new List<Id>();
        List<Attachment> lstAttachment = new List<Attachment>();
        List<Component_FAT__c> lstComponents = new List<Component_FAT__c>();
        String strXML = STRING_DEPLOYMENT_PACKAGE_OPEN_XML_PACKAGE_TAG;
        savePreDeploymentManualSteps();
        savePostDeploymentManualSteps();
        saveDeploymentComponents();

        //Get approved component names.
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponent : lstDeploymentComponents) {
            if(objDeploymentComponent.strMetadataAction == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_PRE_DELETION && 
                        objDeploymentComponent.boolIsApproved == true) {
                lstComponentsId.add(objDeploymentComponent.idComponent);
            }
        }

        //Get component list
        lstComponents = [SELECT Id, APIName_FAT__c, Type_FAT__c FROM Component_FAT__c WHERE Id IN :lstComponentsId LIMIT 50000];
        if(!lstComponents.isEmpty()) {
            for(Component_FAT__c objComponent : lstComponents) {
                if(!setTypeNames.contains(objComponent.Type_FAT__c)) {
                    setTypeNames.add(objComponent.Type_FAT__c);
                }
            }

            //Create XML file.
            for(String strTypeName : setTypeNames){
                strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_TYPES_TAG;
                for(Component_FAT__c objComponent : lstComponents) {
                    if(strTypeName == objComponent.Type_FAT__c) {
                        strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_MEMBERS_TAG + objComponent.APIName_FAT__c + STRING_DEPLOYMENT_PACKAGE_CLOSE_MEMBERS_TAG;
                    }
                }
                strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_NAME_TAG + strTypeName + STRING_DEPLOYMENT_PACKAGE_CLOSE_NAME_TAG + STRING_DEPLOYMENT_PACKAGE_CLOSE_TYPES_TAG;
            }
            strXML = strXML + STRING_DEPLOYMENT_PACKAGE_CLOSE_XML_PACKAGE_TAG;

            //Create or update deployment record attachment.
            blbXML = Blob.valueOf(strXML);
            lstAttachment = [SELECT Id, Name, Body, ContentType, ParentId FROM Attachment WHERE Name = :(STRING_DEPLOYMENT_PACKAGE_PRE_DELETION_NAME + 
                    STRING_DEPLOYMENT_PACKAGE_DOT_FILE_EXTENSION) AND ParentId = :objDeployment.Id];
            if(lstAttachment.isEmpty()) {
                Attachment objAttachment = new Attachment();
                objAttachment.Name = STRING_DEPLOYMENT_PACKAGE_PRE_DELETION_NAME + STRING_DEPLOYMENT_PACKAGE_DOT_FILE_EXTENSION ;
                objAttachment.Body = blbXML;
                objAttachment.ContentType = STRING_DEPLOYMENT_PACKAGE_FILE_EXTENSION;
                objAttachment.ParentId = objDeployment.Id;
                insert objAttachment;
                idPreDeploymentDestructivePackage = objAttachment.Id;
            } else {
                for(Attachment objAttachment : lstAttachment) {
                    objAttachment.Body = blbXML;
                    update objAttachment;
                    idPreDeploymentDestructivePackage = objAttachment.Id;
                }
            }
        }
    }

    /**
     * Method to create post-deployment destructive changes package.
     */
    private void createPostDeploymentDestructivePackage() {
        Blob blbXML;
        Id idAttachment;
        Set<String> setTypeNames = new Set<String>();
        List<Id> lstComponentsId = new List<Id>();
        List<Attachment> lstAttachment = new List<Attachment>();
        List<Component_FAT__c> lstComponents = new List<Component_FAT__c>();
        String strXML = STRING_DEPLOYMENT_PACKAGE_OPEN_XML_PACKAGE_TAG;
        savePreDeploymentManualSteps();
        savePostDeploymentManualSteps();
        saveDeploymentComponents();

        //Get approved component names.
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponent : lstDeploymentComponents) {
            if(objDeploymentComponent.strMetadataAction == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_METADATA_ACTION_POST_DELETION && 
                    objDeploymentComponent.boolIsApproved == true) {
                lstComponentsId.add(objDeploymentComponent.idComponent);
            }
        }

        //Get component list
        lstComponents = [SELECT Id, APIName_FAT__c, Type_FAT__c FROM Component_FAT__c WHERE Id IN :lstComponentsId LIMIT 50000];
        if(!lstComponents.isEmpty()) {
            for(Component_FAT__c objComponent : lstComponents) {
                if(!setTypeNames.contains(objComponent.Type_FAT__c)) {
                    setTypeNames.add(objComponent.Type_FAT__c);
                }
            }

            //Create XML file.
            for(String strTypeName : setTypeNames){
                strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_TYPES_TAG;
                for(Component_FAT__c objComponent : lstComponents) {
                    if(strTypeName == objComponent.Type_FAT__c) {
                        strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_MEMBERS_TAG + objComponent.APIName_FAT__c + STRING_DEPLOYMENT_PACKAGE_CLOSE_MEMBERS_TAG;
                    }
                }
                strXML = strXML + STRING_DEPLOYMENT_PACKAGE_OPEN_NAME_TAG + strTypeName + STRING_DEPLOYMENT_PACKAGE_CLOSE_NAME_TAG + STRING_DEPLOYMENT_PACKAGE_CLOSE_TYPES_TAG;
            }
            strXML = strXML + STRING_DEPLOYMENT_PACKAGE_CLOSE_XML_PACKAGE_TAG;

            //Create deployment record attachment.
            blbXML = Blob.valueOf(strXML);
            lstAttachment = [SELECT Id, Name, Body, ContentType, ParentId FROM Attachment WHERE Name = :(STRING_DEPLOYMENT_PACKAGE_POST_DELETION_NAME + 
                    STRING_DEPLOYMENT_PACKAGE_DOT_FILE_EXTENSION) AND ParentId = :objDeployment.Id];
            if(lstAttachment.isEmpty()) {
                Attachment objAttachment = new Attachment();
                objAttachment.Name = STRING_DEPLOYMENT_PACKAGE_POST_DELETION_NAME + STRING_DEPLOYMENT_PACKAGE_DOT_FILE_EXTENSION ;
                objAttachment.Body = blbXML;
                objAttachment.ContentType = STRING_DEPLOYMENT_PACKAGE_FILE_EXTENSION;
                objAttachment.ParentId = objDeployment.Id;
                insert objAttachment;
                idPostDeploymentDestructivePackage = objAttachment.Id;
            } else {
                for(Attachment objAttachment : lstAttachment) {
                    objAttachment.Body = blbXML;
                    update objAttachment;
                    idPostDeploymentDestructivePackage = objAttachment.Id;
                }
            }
        }
    }

    /**
     * Method to create task for rejected components.
     */
    private void createTaskForRejectedComponents() {
        List<Task> lstTask = new List<Task>();
        List<DeploymentComponentsWrapperClass_FAT> lstDeploymentComponentsWrapper = new List<DeploymentComponentsWrapperClass_FAT>();
        Map<Id, DeploymentComponentsWrapperClass_FAT> mapDeploymentComponents = new Map<Id, DeploymentComponentsWrapperClass_FAT>();

        //Create tasks for rejected components.
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponentElement : lstDeploymentComponents) {
            if(!objDeploymentComponentElement.boolIsApproved) {
                lstDeploymentComponentsWrapper.add(objDeploymentComponentElement);
            }
        }
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponentElement : lstDeploymentComponentsWrapper) {
            mapDeploymentComponents.put(objDeploymentComponentElement.idComponent, objDeploymentComponentElement);
        }
        if(!mapDeploymentComponents.isEmpty()) {
            for(FeatureBranchComponent_FAT__c objFeatureBranchComponent : lstFeatureBranchComponents) {
                if(mapDeploymentComponents.containsKey(objFeatureBranchComponent.Component_FAT__r.Id)) {
                    Task objTask = new Task();
                    if(objFeatureBranchComponent.Id == mapDeploymentComponents.get(objFeatureBranchComponent.Component_FAT__r.Id).idFeatureBranchComponent) {
                        objTask.Subject = STRING_DEPLOYMENT_TASK_NAME;
                        objTask.OwnerId = mapDeploymentComponents.get(objFeatureBranchComponent.Component_FAT__r.Id).idFeatureBranchOwner;
                        objTask.WhatId = mapDeploymentComponents.get(objFeatureBranchComponent.Component_FAT__r.Id).idFeatureBranchComponent;
                        objTask.Status = STRING_DEPLOYMENT_TASK_STATUS;
                        objTask.Priority = STRING_DEPLOYMENT_TASK_PRIORITY;
                        objTask.Description = mapDeploymentComponents.get(objFeatureBranchComponent.Component_FAT__r.Id).strRejectionReason;
                        lstTask.add(objTask);
                    } else {
                        objTask.Subject = STRING_DEPLOYMENT_TASK_NAME;
                        objTask.OwnerId = objFeatureBranchComponent.OwnerId;
                        objTask.WhatId = objFeatureBranchComponent.Id;
                        objTask.Status = STRING_DEPLOYMENT_TASK_STATUS;
                        objTask.Priority = STRING_DEPLOYMENT_TASK_PRIORITY;
                        objTask.Description = STRING_DEPLOYMENT_TASK_SECONDARY_MESSAGE + 
                                mapDeploymentComponents.get(objFeatureBranchComponent.Component_FAT__r.Id).strFeatureBranchComponentName;
                        lstTask.add(objTask);
                    }
                }
            }
        }

        //Create tasks for rejected pre-deployment manual steps.
        for(DeploymentManualStepsWrapperClass_FAT objPreDeploymentManualStep : lstPreDeploymentManualSteps) {
            if(!objPreDeploymentManualStep.boolIsApproved) {
                Task objTask = new Task();
                objTask.Subject = STRING_DEPLOYMENT_TASK_NAME;
                objTask.OwnerId = objPreDeploymentManualStep.idFeatureBranchOwner;
                objTask.WhatId = objPreDeploymentManualStep.idFeatureBranchComponent;
                objTask.Status = STRING_DEPLOYMENT_TASK_STATUS;
                objTask.Priority = STRING_DEPLOYMENT_TASK_PRIORITY;
                objTask.Description = objPreDeploymentManualStep.strRejectionReason;
                lstTask.add(objTask);
            }
        }

        //Create tasks for rejected post-deployment manual steps.
        for(DeploymentManualStepsWrapperClass_FAT objPostDeploymentManualStep : lstPostDeploymentManualSteps) {
            if(!objPostDeploymentManualStep.boolIsApproved) {
                Task objTask = new Task();
                objTask.Subject = STRING_DEPLOYMENT_TASK_NAME;
                objTask.OwnerId = objPostDeploymentManualStep.idFeatureBranchOwner;
                objTask.WhatId = objPostDeploymentManualStep.idFeatureBranchComponent;
                objTask.Status = STRING_DEPLOYMENT_TASK_STATUS;
                objTask.Priority = STRING_DEPLOYMENT_TASK_PRIORITY;
                objTask.Description = objPostDeploymentManualStep.strRejectionReason;
                lstTask.add(objTask);
            }
        }
        insert lstTask;
    }

    /**
     * Method to update feature branch component status.
     */
    public void UpdateFeatureBranchComponentStatus() {
        List<FeatureBranchComponent_FAT__c> lstUpdatedFeatureBranchComponent = new List<FeatureBranchComponent_FAT__c>();
        Map<String, Boolean> mapDeploymentComponentsApproved = new Map<String, Boolean>();
        Map<Id, Boolean> mapPreDeploymentManualStepsApproved = new Map<Id, Boolean>();
        Map<Id, Boolean> mapPostDeploymentManualStepsApproved = new Map<Id, Boolean>();
        Map<Id, FeatureBranch_FAT__c> mapUpdatedFeatureBranches = new Map<Id, FeatureBranch_FAT__c>();
        Map<Id, FeatureBranch_FAT__c> mapFeatureBranches = new Map<Id, FeatureBranch_FAT__c>();
        Map<Id, FeatureBranchComponent_FAT__c> mapFeatureBranchComponents = new Map<Id, FeatureBranchComponent_FAT__c>();
        for(FeatureBranch_FAT__c objFeatureBranch : lstFeatureBranches) {
            mapFeatureBranches.put(objFeatureBranch.Id, objFeatureBranch);
        }
        for(DeploymentComponentsWrapperClass_FAT objDeploymentComponent : lstDeploymentComponents) {
            mapDeploymentComponentsApproved.put(objDeploymentComponent.strComponentName, objDeploymentComponent.boolIsApproved);
        }
        for(DeploymentManualStepsWrapperClass_FAT objPreDeploymentManualStep : lstPreDeploymentManualSteps) {
            mapPreDeploymentManualStepsApproved.put(objPreDeploymentManualStep.idFeatureBranchComponent, objPreDeploymentManualStep.boolIsApproved);
        }
        for(DeploymentManualStepsWrapperClass_FAT objPostDeploymentManualStep : lstPostDeploymentManualSteps) {
            mapPostDeploymentManualStepsApproved.put(objPostDeploymentManualStep.idFeatureBranchComponent, objPostDeploymentManualStep.boolIsApproved);
        }

        //Update feature branch components.
        for(FeatureBranchComponent_FAT__c objFeatureBranchComponent : lstAllFeatureBranchComponents) {
            if(mapDeploymentComponentsApproved.containsKey(objFeatureBranchComponent.Component_FAT__r.APIName_FAT__c)) {
                if(mapDeploymentComponentsApproved.get(objFeatureBranchComponent.Component_FAT__r.APIName_FAT__c)) {
                    objFeatureBranchComponent.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_DEPLOYED;
                } else {
                    objFeatureBranchComponent.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_REJECTED;
                }
                lstUpdatedFeatureBranchComponent.add(objFeatureBranchComponent);
            }
        }

        //Update pre-deployment manual steps.
        for(FeatureBranchComponent_FAT__c objFeatureBranchComponent : lstPreDeploymentFeatureBranchComponents) {
            if(mapPreDeploymentManualStepsApproved.containsKey(objFeatureBranchComponent.Id)) {
                if(mapPreDeploymentManualStepsApproved.get(objFeatureBranchComponent.Id)) {
                    objFeatureBranchComponent.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_DEPLOYED;
                } else {
                    objFeatureBranchComponent.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_REJECTED;
                }
                lstUpdatedFeatureBranchComponent.add(objFeatureBranchComponent);
            }
        }

        //Update post-deployment manual steps.
        for(FeatureBranchComponent_FAT__c objFeatureBranchComponent : lstPostDeploymentFeatureBranchComponents) {
            if(mapPostDeploymentManualStepsApproved.containsKey(objFeatureBranchComponent.Id)) {
                if(mapPostDeploymentManualStepsApproved.get(objFeatureBranchComponent.Id)) {
                    objFeatureBranchComponent.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_DEPLOYED;
                } else {
                    objFeatureBranchComponent.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_REJECTED;
                }
                lstUpdatedFeatureBranchComponent.add(objFeatureBranchComponent);
            }
        }

        //Update feature branches.
        for(FeatureBranchComponent_FAT__c objFeatureBranchComponent : lstUpdatedFeatureBranchComponent) {
            if(mapFeatureBranches.containsKey(objFeatureBranchComponent.FeatureBranch_FAT__c)) {
                FeatureBranch_FAT__c objFeatureBranch = new FeatureBranch_FAT__c(); 
                objFeatureBranch = mapFeatureBranches.get(objFeatureBranchComponent.FeatureBranch_FAT__c);
                if(objFeatureBranchComponent.Status_FAT__c == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_DEPLOYED) {
                    if(objFeatureBranch.Status_FAT__c == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_DEPLOYED || objFeatureBranch.Status_FAT__c == 
                            STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_READY_FOR_DEPLOYMENT) {
                        objFeatureBranch.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_DEPLOYED;
                    } else {
                        objFeatureBranch.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_PARTIALLY_COMPLETED;
                    }
                } else {
                    if(objFeatureBranch.Status_FAT__c == STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_REJECTED || objFeatureBranch.Status_FAT__c == 
                            STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_READY_FOR_DEPLOYMENT) {
                        objFeatureBranch.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_COMPONENT_STATUS_REJECTED;
                    } else {
                        objFeatureBranch.Status_FAT__c = STRING_DEPLOYMENT_FEATURE_BRANCH_STATUS_PARTIALLY_COMPLETED;
                    }
                }
                objFeatureBranch.Origin_FAT__c = objDeployment.Destination_FAT__c;
                objFeatureBranch.Destination_FAT__c = objDeployment.NextEnvironment_FAT__c;
                mapFeatureBranches.remove(objFeatureBranch.Id);
                mapFeatureBranches.put(objFeatureBranch.Id, objFeatureBranch);
            }
        }

        //Update elements.
        update lstUpdatedFeatureBranchComponent;
        update mapFeatureBranches.values();
    }
}