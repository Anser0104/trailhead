public class AccountHandler {
    public static Account insertNewAccount(String accName){
       Account acc = new Account();
               acc.name = accName;
        	   acc.Industry ='Education';
        try{
            insert acc;
                      
        system.debug('insreted '+acc.name);
        return acc;
        }
        catch(Exception e){
        system.debug('Exception');   
        return null;
    }
    }
    }