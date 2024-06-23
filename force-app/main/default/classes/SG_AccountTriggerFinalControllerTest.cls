@isTest
public  class SG_AccountTriggerFinalControllerTest {
    
    @isTest public static void testCreateRelatedOppOrContacts(){
        List<Account> accList=new List<Account>();
        for(Integer i=1;i<=10;i++){
            Account acc=new Account();
            acc.Name='Test Account'+i;
            if(Math.mod(i,2)==0){
                acc.New_Contact__c=true;
            }
            else{
                acc.Active__c='Yes';
                acc.New_Opportunity__c=true;
            }
            accList.add(acc);
        }

        Test.startTest();
            insert accList;
        Test.stopTest();

        List<Contact> conList=[SELECT AccountId FROM Contact WHERE AccountId =: accList[1].Id];
        List<Opportunity> oppList=[SELECT AccountId FROM Opportunity WHERE AccountId =: accList[0].Id];

        System.assert(conList!=null);
        System.assert(oppList!=null);
    }

    @isTest public static void testUpdatePhone(){
        List<Account> accList=new List<Account>();
        for(Integer i=1;i<=5;i++){
                Account acc=new Account();
                acc.Phone='111111111';
                acc.Name='test account '+i;
                accList.add(acc);
        }
        Test.startTest();
        insert accList;
         for(Account acc:accList){
            acc.Phone='23212111';
        }
            
        update accList;
         
        Test.stopTest();

        List<Account> a=[SELECT Id,Phone,Description FROM Account WHERE Id=:accList[0].Id];
        
        
        
        System.assertEquals('23212111',a[0].Phone);

    }

    @isTest public static void testCopyBillingToShippingAddressInsert(){

        List<Account> accList=new List<Account>();
        for(Integer i=1;i<=3;i++){
            Account acc=new Account();
            acc.Name='Test '+i;
            acc.Copy_Billing_to_Shipping__c=true;
            acc.BillingStreet='Test street';
            acc.BillingCity='Test city';
            acc.BillingState='Test state';
            acc.BillingCountry='Test country';
            acc.BillingPostalCode='Test code';
            accList.add(acc);
        }
        Test.startTest();
        insert accList;
        Test.stopTest();

        List<Account> account=[SELECT Id,BillingStreet,ShippingStreet FROM Account WHERE Id=:accList[0].Id];

        System.assertEquals('Test street',account[0].ShippingStreet);
    }



    @isTest public static void testCopyBillingToShippingAddressUpdate(){

        List<Account> accList=new List<Account>();
        for(Integer i=1;i<=3;i++){
            Account acc=new Account();
            acc.Name='Test '+i;
            
            acc.BillingStreet='Test street';
            acc.BillingCity='Test city';
            acc.BillingState='Test state';
            acc.BillingCountry='Test country';
            acc.BillingPostalCode='Test code';
            accList.add(acc);
        }
        Test.startTest();
        insert accList;
        for(Account acc:accList){
            acc.Copy_Billing_to_Shipping__c=true;
        }
        update accList;

        Test.stopTest();

        List<Account> account=[SELECT Id,BillingStreet,ShippingStreet FROM Account WHERE Id=:accList[0].Id];

        System.assertEquals('Test street',account[0].ShippingStreet);
    }

    @isTest public static void testRatingInsert(){
        Account acc1=new Account(
            Name='Test Account',
            Industry='Media'
        );
        Test.startTest();
        insert acc1;
        Test.stopTest();
        ID accId=acc1.Id;

        List<Account> accInserted=[SELECT Id,Rating FROM Account WHERE Id=:accId];
        System.assertEquals('Hot',accInserted[0].Rating);

    }
    
    @isTest public static void testRatingUpdate(){
        Account acc1=new Account(
            Name='Test Account',
            Industry='Education'
        );
        Test.startTest();
        insert acc1;
        
        acc1.Industry='Media';
        update acc1;
        
        Test.stopTest();
        
        ID accId=acc1.Id;

        List<Account> accUpdated=[SELECT Id,Rating FROM Account WHERE Id=:accId];
        System.assertEquals('Hot',accUpdated[0].Rating);
        
    }

        @isTest public static void testHandleCopyAccountBillingAddressToRelatedContactsMailingAddress(){
            Account acc=new Account();
            acc.Name='Test Account';
            
            Test.startTest();
                insert acc;
                ID accId=acc.Id;
                Contact con=new Contact();
                con.AccountId=accId;
                con.FirstName='test';
                con.LastName='Contact';
                insert con;
            acc.BillingCity='test city';
            acc.BillingCountry='test country';
            acc.BillingPostalCode='testtest';
            acc.BillingState='test state';
            acc.BillingStreet='test street';
            update acc;

            Test.stopTest();
            List<Contact> conList=[SELECT Id,AccountId,MailingStreet FROM Contact WHERE AccountId =: accId];

            System.assertEquals('test street', conList[0].MailingStreet);
            
            
        }
    @isTest public static void testUpdateRelatedOppStage(){
        Account acc=new Account();
        acc.Name='test account';
        acc.Active__c='Yes';

        Test.startTest();
        insert acc;
        ID accId=acc.Id;
        Opportunity opp=new Opportunity();
        opp.Name='test opp';
        opp.AccountId=accId;
        opp.CloseDate=System.today();
        opp.StageName='Prospecting';
        insert opp;
        
        acc.Active__c='No';
        update acc;
        Test.stopTest();

        List<Opportunity> oppList=[SELECT Id,AccountId,StageName FROM Opportunity WHERE AccountId=:accId];

        System.assertEquals('Closed Lost',oppList[0].StageName);

    }

    @isTest public static void testPreventAccountDeletion(){
        Account acc=new Account();
        acc.Name='test account';
        acc.Active__c='Yes';

        Test.startTest();
        insert acc;
		Boolean exceptionThrown=false;
        
        try{
            delete acc;
        }catch(Exception e){
            exceptionThrown=true;
            
            System.assert(e.getMessage().contains(Label.Prevent_Account_Deletion));
        }
			
        
        Test.stopTest();
        System.assertEquals(true,exceptionThrown);
    }

    @isTest public static void testPreventAccountUpdation(){

        Account acc=new Account();
        acc.Name='test account';
        //set the created date to check 
        

        Test.startTest();
        insert acc;
        Test.setCreatedDate(acc.Id, DateTime.newInstance(2023,03,20));
        acc.Rating='Hot';
        Boolean exceptionOcurred=false;
        try{
            update acc;

        }catch(Exception e){
            exceptionOcurred=true;
            System.assert(e.getMessage().contains(Label.Account_Cannnot_be_Edited));
        }

        System.assertEquals(true, exceptionOcurred);

        Test.stopTest();
    }
    
}