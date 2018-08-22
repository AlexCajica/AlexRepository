public with sharing class RayTests {

    private IntegrationWrapperClass_CF objIntegration;
    
    public Continuation continuation() {
        objIntegration = IntegrationClass_CF.continuationCallout('Test', 'continuationresponse', 'ContinuationMethod');
        HttpRequest objHttpRequest = new HttpRequest();
        objHttpRequest.setMethod(objIntegration.strRequestMethod);
        objHttpRequest.setBody(objIntegration.strRequestBody);
        objHttpRequest.setEndpoint(objIntegration.strRequestEndpoint);
        objHttpRequest.setHeader('user-agent', ApexPages.currentPage().getHeaders().get('USER-AGENT'));
        Continuation objContinuation = new Continuation(objIntegration.intTimeout);
        objIntegration.strRequestKey = objContinuation.addHttpRequest(objHttpRequest);
        objContinuation.continuationMethod = objIntegration.strCallbackMethodName;
        return objContinuation;
    }
    
    public Object continuationresponse() {
        objIntegration = IntegrationClass_CF.getContinuationResponse(objIntegration);
        System.debug(objIntegration.strResponseBody);
        return null;
    }
    
    public void synch() {
        objIntegration = IntegrationClass_CF.synchronousCallout('Test', 'SynchMethod');
        System.debug(objIntegration.strResponseBody);
    }
    
    public void asynch() {
        IntegrationClass_CF.asynchronousCallout('Test', 'AsynchMethod');
    }
    
    public void noparameters() {
        objIntegration = IntegrationClass_CF.synchronousCalloutNoParameters('NoParameters', 'master...FB-00321');
        System.debug(objIntegration.strResponseBody);
    }
}