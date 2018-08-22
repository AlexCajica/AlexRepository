/**
 * Helper class for RepositoryTest_FAT which simulates a Web Service response.
 * <p /><p />
 * @author Gabriel Coronel
 */
@isTest
global class MockHttpRepositoryNullRespTest_FAT implements HttpCalloutMock {
    
     /**
     * Simulates the Web Service response for the test class.
     *
     * @param objRequest    Simulated request.
     * @return HTTP Response.
     */
    global HTTPResponse respond(HTTPRequest objHttpRequest) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        //String strReponse = '{"ref": "refs/heads/master","url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/master","object": {"sha": "5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b","type": "commit","url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b"}}';

        // Create a fake response
        HttpResponse objHttpResponse = new HttpResponse();
        objHttpResponse.setHeader('Content-Type', 'application/json');
        objHttpResponse.setBody(null);
        objHttpResponse.setStatusCode(201);
        return objHttpResponse;
    }
}