@RestResource(urlMapping='/createAccount/*')
global with sharing class createAccountRestClass {
 @HttpPost
    global static String createAccountRecord(String AccName, String AccIndustry){
        Account acc = new Account();
        acc.name = AccName;
        acc.Industry = AccIndustry;
        insert acc;
         String returnResponse = JSON.serialize(acc.Id);
        return returnResponse;        
    }
}