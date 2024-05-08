trigger triggerOne on Account (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        if(!trigger.new.isEmpty()){
            for(Account acc:trigger.new){
                if(acc.Phone==null){
                    acc.Phone.addError('Phone field Cannt be null');
                }
            }
        }
        
    }
}