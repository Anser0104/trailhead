public class SalesforceRequestCallouttoOrgA {
    @AuraEnabled(cacheable=true)// Request to Fetch Records
    public static List<Account> getAccountsfromOrgA(String searchKey){
        List<Account> accountList = new List<Account>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Named Credential: SFDCA - Two Requests for Access token and Authorization
        request.setEndpoint('callout:SFDCA/services/apexrest/AccountAPI/'+searchKey);
        request.setHeader('Content-Type', 'Application/JSON');
        request.setMethod('GET');        
        try {
            HttpResponse response = http.send(request);
            if(response.getStatusCode() == 200){
                //Parse the response and map it to Account records
                List<Account> accounts = (List<Account>) JSON.deserialize(response.getBody(), List<Account>.class);
                accountList.addAll(accounts);                 
            }             
        } 
        catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }        
        system.debug('List of Account Records: '+accountList);
        return accountList;
    }
    
    @AuraEnabled(cacheable=true) // Resquest to Create Record
    public static String PostAccountsToOrgA(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDCA/services/apexrest/AccountAPI');        
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"Name":"TestDummyAcct05","Email__c":"connest@125gmail.com","Industry":"Communications","Phone":"8122559974"}');
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 201){
            // deserialize the response to get Account Id
            String account = (String) JSON.deserialize(response.getBody(), String.class);
            System.debug('Account Details: ' +account);
            return account;
        } 
        else {
            throw new CalloutException('Failed to create account: ' + response.getStatus());
        } 
    } 
    
    @AuraEnabled(cacheable=true) // Resquest to Update Record
    public static String updateAccountofOrgA(){
        Http http = new Http();
        HttpRequest request= new HttpRequest();
        request.setEndpoint('callout:SFDCA/services/apexrest/AccountAPI');
        request.setMethod('PUT');
        request.setHeader('Content-Type','application/json;charset=UTF-8');
        request.setBody('{"Id":"0015g00000HZZ81AAH","Name":"Nossan Anser Basha","Phone":"8122559974","Industry":"Communications"}');
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            System.debug(' Account Details: ' +response.getBody());
            String accountStatus = (String) JSON.deserialize(response.getBody(), String.class);
            System.debug('Updated Account Details: ' +accountStatus);
            return accountStatus;            
        }else {
            throw new CalloutException('Failed to Updated Account' +response.getStatus());
        }      
    }
}