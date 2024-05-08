trigger trigger_Two on Account (before insert,before update) {
    //before insertion or updation 
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        //null check     
        if(!trigger.new.isEmpty()){
            for (Account acc:trigger.new){
                //copy billiing address to shipping address 
                if(acc.BillingStreet!=null){
                    acc.ShippingStreet=acc.BillingStreet;
                }
                if(acc.BillingCity!=null){
                    acc.ShippingCity=acc.BillingCity;
                }
                if(acc.BillingState!=null){
                    acc.ShippingState=acc.BillingState;
                }
                if(acc.BillingCountry!=null){
                    acc.ShippingCountry=acc.BillingCountry;

                }
                if(acc.BillingPostalCode!=null)
                acc.ShippingPostalCode=acc.BillingPostalCode;
            }
        }
    }
}