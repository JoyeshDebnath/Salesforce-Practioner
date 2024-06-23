trigger AccountAddressTrigger on Account (before insert,before update,before delete,
                                          after insert,after update,after delete,
                                          after undelete) {

                                              if(Trigger.isBefore){
                                                  if(Trigger.isInsert){
                                                      AccountAddressTriggerHandler.updateShippingPostalCodeInsert(Trigger.new);
                                                  }
                                                  if(Trigger.isUpdate){
                                                      AccountAddressTriggerHandler.updateShippingPostalCodeUpdate(Trigger.New,Trigger.oldMap);
                                                  }
                                              }
}