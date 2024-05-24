public  class ContractTriggerHandler {
    public static void sendEmailNotification(List<Contact> conList){
        
        List<Messaging.Email> emailList = new List<Messaging.Email>();    
        
        for(Contact con:conList){
            if(con.Email!=null){
                Messaging.SingleEmailMessage emailMsg=new Messaging.SingleEmailMessage();
                String[] toAddress=new String[]{con.Email};
                emailMsg.setToAddresses(toAddress);
                String emailSubject='Welcome '+con.FirstName+' '+con.LastName+'  😊😊';
                emailMsg.setSubject(emailSubject);
                String displayName='Joyesh Debnath ';
                emailMsg.setSenderDisplayName(displayName);

                String emailContent='Hi there '+con.FirstName+'  ,<br/><br/>'+
                                    'Welcome To Salesforce EcoSystem 🎯 <br/><br/>'+
                                    'Thank You';
                
                emailMsg.setHtmlBody(emailContent);
                emailList.add(emailMsg);

            }
        }

        Messaging.sendEmail(emailList);
    }
}