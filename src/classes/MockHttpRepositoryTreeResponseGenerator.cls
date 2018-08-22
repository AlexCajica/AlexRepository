@isTest
global class MockHttpRepositoryTreeResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest objHttpRequest) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        String strReponse = '{ ' +
  '"sha": "927965dde6413b08395fb9b83ea3629b80fde1e4",' +
  '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/trees/927965dde6413b08395fb9b83ea3629b80fde1e4",' +
  '"tree": [' +
    '{' +
      '"path": "CreateNewBranch_Callouts_FAT.cls",' +
      '"mode": "100644",' +
      '"type": "blob",' +
      '"sha": "c23a202b429450af61b10247a21d519a892140b0",' +
      '"size": 3499,' +
      '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/blobs/c23a202b429450af61b10247a21d519a892140b0"' +
    '},' +
    '{' +
      '"path": "README.md",' +
      '"mode": "100644",' +
      '"type": "blob",' +
      '"sha": "9e5a613534e446daa7e89a8456abaf30096bf6db",' +
      '"size": 10,' +
      '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/blobs/9e5a613534e446daa7e89a8456abaf30096bf6db"' +
    '},' +
    '{' +
      '"path": "SearchBranch_Callouts_FAT.cls",' +
      '"mode": "100644",' +
      '"type": "blob",' +
      '"sha": "d370624857cdf7ecce97bb5aba36f69e55345e1c",' +
      '"size": 8956,' +
      '"url": "https://api.github.com/repos/gcoronel1/TestFAT/git/blobs/d370624857cdf7ecce97bb5aba36f69e55345e1c"' +
    '}' +
  '],' +
  '"truncated": false' +
'}';
        // Create a fake response
        HttpResponse objHttpResponse = new HttpResponse();
        objHttpResponse.setHeader('Content-Type', 'application/json');
        objHttpResponse.setBody(strReponse);
        objHttpResponse.setStatusCode(201);
        return objHttpResponse;
    }
}