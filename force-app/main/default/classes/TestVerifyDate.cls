@isTest
public class TestVerifyDate {

    @isTest static void testDateWithin30Days(){
        date date1=date.newInstance(2000,02, 21);
        date date2=date.newInstance(2000, 03, 03);
        Date resDate=VerifyDate.CheckDates(date1,date2);
        System.assertEquals(date2, resDate);
    }
    
    @isTest static void testDateNotwithin30Days(){
        date date1=date.newInstance(2000, 03, 21);
        date date2=date.newInstance(2000, 04, 28);
        Date resDate=VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date.newInstance(2000, 03,31 ), resDate);
    } 
    
    @isTest static void testInvalidDateWithin30days(){
        date date1=date.newInstance(2000, 04, 11);
        date date2=date.newInstance(2000, 04, 05);
        Boolean res=VerifyDate.DateWithin30Days(date1,date2);
        System.assertEquals(false,res);
    }
}