/**
 * Helper class for RepositoryTest_FAT which simulates a Web Service response.
 * <p /><p />
 * @author Gabriel Coronel
 */
@isTest
global class MockHttpRepositoryRespTest_FAT implements HttpCalloutMock {
    
     /**
     * Simulates the Web Service response for the test class.
     *
     * @param objRequest    Simulated request.
     * @return HTTP Response.
     */
    global HTTPResponse respond(HTTPRequest objHttpRequest) {
        String strResponseBody = '[' +
            '{' +
                '"ref": "refs/heads/FB-00047",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/FB-00047",' +
                '"object": {' +
                    '"sha": "5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b"' +
                '}' +
            '},' +
            '{' +
                '"ref": "refs/heads/FB-00048",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/FB-00048",' +
                '"object": {' +
                    '"sha": "5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b"' +
                '}' +
            '},' +
            '{' +
                '"ref": "refs/heads/FB-00049",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/FB-00049",' +
                '"object": {' +
                    '"sha": "d120c42a9656917ce1a3eb9567aaac88ae8e90c0",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/d120c42a9656917ce1a3eb9567aaac88ae8e90c0"' +
                '}' +
            '},' +
            '{' +
                '"ref": "refs/heads/FB-00050",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/FB-00050",' +
                '"object": {' +
                    '"sha": "5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b"' +
                '}' +
            '},' +
            '{' +
                '"ref": "refs/heads/FB-00051",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/FB-00051",' +
                '"object": {' +
                    '"sha": "5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b"' +
                '}' +
            '},' +
            '{' +
                '"ref": "refs/heads/FB-00052",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/FB-00052",' +
                '"object": {' +
                    '"sha": "5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b"' +
                '}' +
            '},' +
            '{' +
                '"ref": "refs/heads/FB-00053",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/FB-00053",' +
                '"object": {' +
                    '"sha": "5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b"' +
                '}' +
            '},' +
            '{' +
                '"ref": "refs/heads/FB-00054",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/FB-00054",' +
                '"object": {' +
                    '"sha": "5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/5ac4f63fe42ba16c7befc5bcd1a7666ffb5b875b"' +
                '}' +
            '},' +
            '{' +
                '"ref": "refs/heads/FB-00359",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/FB-00359",' +
                '"object": {' +
                    '"sha": "c16a731c36080db818d2e029055119662d947399",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/c16a731c36080db818d2e029055119662d947399"' +
                '}' +
            '},' +
            '{' +
                '"ref": "refs/heads/master",' +
                '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/refs/heads/master",' +
                '"object": {' +
                    '"sha": "daa7abc758fb10273f32346f29cbc77a89376015",' +
                    '"type": "commit",' +
                    '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/commits/daa7abc758fb10273f32346f29cbc77a89376015"' +
                '}' +
            '}' +
        ']';

        // Create a fake response
        HttpResponse objHttpResponse = new HttpResponse();
        objHttpResponse.setHeader('Content-Type', 'application/json');
        objHttpResponse.setBody(strResponseBody);
        objHttpResponse.setStatusCode(201);
        return objHttpResponse;
    }
}