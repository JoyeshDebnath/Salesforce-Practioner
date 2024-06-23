public  class SG_AccountTriggerFinalController {
    public static void createRelatedContactOrOpp(List<Account> accList){
        //create reltaed contact 
        List<Contact> conList=new List<Contact>();
        List<Opportunity> oppList=new List<Opportunity>();
        
        for(Account acc:accList){
            if(acc.New_Contact__c){
                Contact con=new Contact();
                con.AccountId=acc.Id;
                con.FirstName=acc.Name;
                con.LastName=acc.Name;
                conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            insert conList;
        }
        //create related opps
        for(Account acc:accList){
            if(acc.Active__c=='Yes' && acc.New_Opportunity__c){
                Opportunity opp=new Opportunity();
                opp.Name=acc.Name;
                opp.StageName='Prospecting';
                opp.CloseDate=System.today();
                opp.AccountId=acc.Id;
                oppList.add(opp);
            }
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }

    public static void handleUpdatePhone(List<Account> newList,Map<Id,Account> oldMap){
        for(Account acc:newList){
            if(acc.Phone!=null && oldMap.get(acc.Id).Phone!=acc.Phone){
                acc.Description='Phone Field is Updated \n'+'  Old Value: '+oldMap.get(acc.Id).Phone +' \n'+'The New Value:'+acc.Phone;
            }
        }
    }

    //Copy Billing To shipping address 


    public static void copyBillingToShippingAddress(List<Account> newAccList,Map<Id,Account> oldMap){

    for(Account acc:newAccList){
        if(
            (oldMap==null && acc.Copy_Billing_to_Shipping__c )
                ||
            (acc.Copy_Billing_to_Shipping__c && (
                oldMap.get(acc.Id).Copy_Billing_to_Shipping__c != acc.Copy_Billing_to_Shipping__c
            ))
        )
                {
                        acc.ShippingCity=acc.BillingCity;
                        acc.ShippingCountry=acc.BillingCountry;
                        acc.ShippingStreet=acc.BillingStreet;
                        acc.ShippingPostalCode=acc.BillingPostalCode;
                        acc.ShippingState=acc.BillingState;


                }
        }
    }

    public static void updateAccountRating(List<Account> newList,Map<Id,Account> oldMap){
        for(Account acc:newList){
            if((oldMap==null && acc.Industry=='Media') ||
                (oldMap!=null && acc.Industry=='Media'))
                {
                    acc.Rating='Hot';
                }
        }
    }
    
    public static void handleAccountPhoneUpdate(List<Account> newList,Map<Id,Account> oldMap){
        List<Contact> conListToUpdate=new List<Contact>();
        Map<Id,Account> accountIdToAccountPhoneMap=new Map<Id,Account>();
        for(Account acc:newList){
            if(oldMap.get(acc.Id).Phone==null ||  oldMap.get(acc.Id).Phone!=acc.Phone){
                //phone field is updated 
                accountIdToAccountPhoneMap.put(acc.Id,acc);
            }
        }
        
        System.debug('map='+accountIdToAccountPhoneMap);
        
       
        
        
       
        
        //check and updated the home phone field 
        if(!accountIdToAccountPhoneMap.isEmpty()){
                for(Contact con:[SELECT Id,AccountId,HomePhone 
                                 FROM Contact 
                                       WHERE 
                                       AccountId IN : accountIdToAccountPhoneMap.keySet() ]){
                    
                     con.HomePhone=accountIdToAccountPhoneMap.get(con.AccountId).Phone;
                    conListToUpdate.add(con);
                }
        }
        System.debug('before update :'+conListToUpdate);
        
        if(!conListToUpdate.isEmpty()){
            update conListToUpdate;
        }
        
    }//handle account phone updation 
    
        public static void handleAccountPhoneUpdate2(List<Account> newList,Map<Id,Account> oldMap){
        List<Contact> conListToUpdate=new List<Contact>();
   		Set<Id> accountIds=new Set<Id>();
        for(Account acc:newList){
            if(oldMap.get(acc.Id).Phone==null ||  oldMap.get(acc.Id).Phone!=acc.Phone){
               accountIds.add(acc.Id);
            }
        }
         
            for(Account acc:[SELECT Id,Phone , 
                             (SELECT Id,AccountId,HomePhone FROM Contacts)
                            FROM Account
                            WHERE Id IN : accountIds
                            ]){
                                for(Contact con : acc.Contacts){
                                    con.HomePhone=acc.Phone;
                                    conListToUpdate.add(con);
                                }
                
            }
         
        if(!conListToUpdate.isEmpty()){
            update conListToUpdate;
        }
        
    }//handle account phone updation 


    public static void handleCopyAccountBillingAddressToRelatedContactsMailingAddress_1(List<Account> newList,Map<Id,Account> oldMap){
            List<Contact> conListToUpdate=new List<Contact>();
            Map<Id,Account> accIdToAccountMap=new Map<Id,Account>();

            for(Account acc:newList){
                    if(
                        oldMap.get(acc.Id).BillingStreet!=acc.BillingStreet
                        ||
                        oldMap.get(acc.Id).BillingState!=acc.BillingState 
                        ||
                        oldMap.get(acc.Id).BillingCountry!=acc.BillingCountry
                        || 
                        oldMap.get(acc.Id).BillingCity!=acc.BillingCity
                        ||
                        oldMap.get(acc.Id).BillingPostalCode!=acc.BillingPostalCode
                        )
                        {
                            accIdToAccountMap.put(acc.Id,acc);
                        }
            }
            if(!accIdToAccountMap.isEmpty()){
                    for(Contact con : [SELECT Id,AccountId,MailingStreet,MailingPostalCode,MailingCity,MailingState,MailingCountry FROM Contact WHERE AccountId IN : accIdToAccountMap.keySet()]){
                        con.MailingCity=accIdToAccountMap.get(con.AccountId).BillingCity;
                        con.MailingCountry=accIdToAccountMap.get(con.AccountId).BillingCountry;
                        con.MailingPostalCode=accIdToAccountMap.get(con.AccountId).BillingPostalCode;
                        con.MailingState=accIdToAccountMap.get(con.AccountId).BillingState;
                        con.MailingStreet=accIdToAccountMap.get(con.AccountId).BillingStreet;

                        conListToUpdate.add(con);
                    }
            }

            if(!conListToUpdate.isEmpty()){
                update conListToUpdate;
            }

    }//approach using maps 




    public static void handleCopyAccountBillingAddressToRelatedContactsMailingAddress_2(List<Account> newList,Map<Id,Account> oldMap){
            List<Contact> conListToUpdate=new List<Contact>();
            Set<Id> accIds=new Set<Id>();

            

            for(Account acc:newList){
                    if(
                        oldMap.get(acc.Id).BillingStreet!=acc.BillingStreet
                        ||
                        oldMap.get(acc.Id).BillingState!=acc.BillingState 
                        ||
                        oldMap.get(acc.Id).BillingCountry!=acc.BillingCountry
                        || 
                        oldMap.get(acc.Id).BillingCity!=acc.BillingCity
                        ||
                        oldMap.get(acc.Id).BillingPostalCode!=acc.BillingPostalCode
                        )
                        {
                            accIds.add(acc.Id);
                        }
            }
            if(!accIds.isEmpty()){
                    for(Account acc : [SELECT Id,BillingCity,BillingStreet,BillingState,BillingCountry,BillingPostalCode , 
                    (SELECT Id,AccountId ,MailingPostalCode,MailingStreet,MailingState,MailingCountry,MailingCity FROM Contacts)
                    FROM Account
                    WHERE Id IN : accIds
                    ]){

                        for(Contact con:acc.Contacts){
                                con.MailingCity=acc.BillingCity;
                                con.MailingCountry=acc.BillingCountry;
                                con.MailingPostalCode=acc.BillingPostalCode;
                                con.MailingState=acc.BillingState;
                                con.MailingStreet=acc.BillingStreet;

                                conListToUpdate.add(con);
                        }
                        
                    }
            }

            if(!conListToUpdate.isEmpty()){
                update conListToUpdate;
            }

    }//approach using parent-chiild soql 

    public static void updateRelatedOppStage(List<Account> newList,Map<Id,Account> oldMap){
        List<Opportunity> oppToBeUpdated=new List<Opportunity>();
        Set<Id> accntIds=new Set<Id>();

        for(Account acc:newList){
            if( (oldMap.get(acc.Id).Active__c=='Yes' || oldMap.get(acc.Id).Active__c==null ) && acc.Active__c=='No'){
                accntIds.add(acc.Id);
            } 
        }

        if(!accntIds.isEmpty()){
            for(Account acc:[SELECT Id, 
                        (SELECT AccountId,Id,Name,StageName FROM Opportunities)
                        FROM Account 
                        WHERE Id In : accntIds
        ]){
                for(Opportunity opp:acc.Opportunities){
                    opp.StageName='Closed Lost';
                    oppToBeUpdated.add(opp);
                }
        }
    }

        if(!oppToBeUpdated.isEmpty()){
            update oppToBeUpdated;
        }
    }

    public static void preventDelete(List<Account> accountList){
        for(Account acc:accountList){
            if(acc.Active__c=='Yes'){
                acc.addError(Label.Prevent_Account_Deletion);
            }
        }
    }

    public static void preventAccountEdit(List<Account> newList,Map<Id,Account> oldMap){
        for(Account acc:newList)
        {
            if(acc.CreatedDate < System.today() - 7 ){
                acc.addError(Label.Account_Cannnot_be_Edited);
            }
        }

        
    }
}