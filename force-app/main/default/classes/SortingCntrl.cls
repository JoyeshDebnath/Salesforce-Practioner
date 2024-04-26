public with sharing class SortingCntrl {
    @AuraEnabled(cacheable =true)
    public static List<Opportunity> fetchOppData(){
        List<Opportunity> oppList = [SELECT Name,Id,Amount FROM Opportunity WHERE Amount!=null];
        return oppList;
    }
}