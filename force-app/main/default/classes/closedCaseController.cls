public with sharing class closedCaseController {
    @AuraEnabled(cacheable=true)
    public static List<CaseWrapper> getClosedCases(){
        List<CaseWrapper> caseList = new List<CaseWrapper>();
        try{
                for(Case caseRecord:[SELECT Id,CaseNumber,Subject,Status FROM Case WHERE Status!='Closed']){
                    CaseWrapper caseWrapper = new CaseWrapper(caseRecord);
                    caseList.add(caseWrapper);
                }
        }catch(Exception error){
            throw new AuraHandledException(error.getMessage());
        }
        return caseList;
    }

    @AuraEnabled(cacheable=true)
    public static void closeSelectedCases(String caseString){
        try{
            List<CaseWrapper> caseList=(List<CaseWrapper>)JSON.deserialize(caseString,List<CaseWrapper>.class);//deserailise the ccase string to list of case wrapper types 
            //iterate over the desreailised string and choose the caseRecords 
            List<Case> caseToUpdate=new List<Case>();
            for(CaseWrapper wrapper:caseList){
                if(wrapper.isSelected==true){
                    Case caseRecord=wrapper.caseRecord;
                    caseRecord.Status='Closed';
                    caseToUpdate.add(caseRecord);
                }
            }
            update caseToUpdate;

        }catch(Exception error){
            throw new AuraHandledException(error.getMessage());
        }
    }

    public class CaseWrapper{
        @AuraEnabled
        public Case caseRecord{ get;set;}
        @AuraEnabled
        public Boolean isSelected{get;set;}


        public CaseWrapper(Case caseRecord){
            this.isSelected = false;
            this.caseRecord = caseRecord;
        }
    }
}