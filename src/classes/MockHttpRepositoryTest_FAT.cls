/**
 * Helper class for RepositoryTest_FAT which simulates a Web Service response.
 * <p /><p />
 * @author Gabriel Coronel
 */
@isTest
global class MockHttpRepositoryTest_FAT implements HttpCalloutMock {
    
     /**
     * Simulates the Web Service response for the test class.
     *
     * @param objRequest    Simulated request.
     * @return HTTP Response.
     */
    global HTTPResponse respond(HTTPRequest objHttpRequest) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        String strReponse = '{ ' +
        '}' +
    ']' +
    '"files": [' +
        '{' +
            '"sha": "1965c72bd51d1990a58b476440b61b0cfd8eca1a",' +
            '"filename": "FileMaster.page",' +
            '"status": "modified",' +
            '"additions": 1,' +
            '"deletions": 0,' +
            '"changes": 1,' +
            '"blob_url": "https://github.com/gcoronel1/TestFAT/blob/b0570087b0e03e659aed7b65568d855f46a018fd/FileMaster.page",' +
            '"raw_url": "https://github.com/gcoronel1/TestFAT/raw/b0570087b0e03e659aed7b65568d855f46a018fd/FileMaster.page",' +
            '"contents_url": "https://api.github.com/repos/gcoronel1/TestFAT/contents/FileMaster.page?ref=b0570087b0e03e659aed7b65568d855f46a018fd",' +
            '"patch": "@@ -1 +1 +2 @@\n qwertyuiop\n+123456789"' +
        '},' +
        '{' +
            '"sha": "0df4468ade9de6c1842093f717d2d9f423ab14a8",' +
            '"filename": "FileMaster1.cls",' +
            '"status": "modified",' +
            '"additions": 1,' +
            '"deletions": 0,' +
            '"changes": 1,' +
            '"blob_url": "https://github.com/gcoronel1/TestFAT/blob/b0570087b0e03e659aed7b65568d855f46a018fd/FileMaster1.cls",' +
            '"raw_url": "https://github.com/gcoronel1/TestFAT/raw/b0570087b0e03e659aed7b65568d855f46a018fd/FileMaster1.cls",' +
            '"contents_url": "https://api.github.com/repos/gcoronel1/TestFAT/contents/FileMaster1.cls?ref=b0570087b0e03e659aed7b65568d855f46a018fd",' +
            '"patch": "@@ -1 +1 +2 @@\n 1234567890\n+qwertyuiop"' +
        '},' +
        '{' +
            '"sha": "41ac5e34d75912fae53b8345c01c0f3efeb23b93",' +
            '"filename": "Test2.cls",' +
            '"status": "added",' +
            '"additions": 1,' +
            '"deletions": 0,' +
            '"changes": 1,' +
            '"blob_url": "https://github.com/gcoronel1/TestFAT/blob/b0570087b0e03e659aed7b65568d855f46a018fd/Test2.cls",' +
            '"raw_url": "https://github.com/gcoronel1/TestFAT/raw/b0570087b0e03e659aed7b65568d855f46a018fd/Test2.cls",' +
            '"contents_url": "https://api.github.com/repos/gcoronel1/TestFAT/contents/Test2.cls?ref=b0570087b0e03e659aed7b65568d855f46a018fd",' +
            '"patch": "@@ -0 +0 +1 @@\n+qwerwqe"' +
        '}' +
    ']' +
'}';
        strReponse = strReponse.replaceAll('\n','').replaceAll('\r','');

        // Create a fake response
        HttpResponse objHttpResponse = new HttpResponse();
        objHttpResponse.setHeader('Content-Type', 'application/json');
        objHttpResponse.setBody(strReponse);
        objHttpResponse.setStatusCode(201);
        return objHttpResponse;
    }
}