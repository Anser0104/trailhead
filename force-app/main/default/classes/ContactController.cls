public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
       list<Contact> contactList =  [
            SELECT FirstName, LastName, Email 
            FROM Contact 
            WITH SECURITY_ENFORCED
            LIMIT 10];
          if(contactList.size()<5) {
            throw new AuraHandledException('Contacts cannot be less than 5');
        }
       	 return contactList;
    }
}