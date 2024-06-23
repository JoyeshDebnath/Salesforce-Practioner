@isTest
public class TestVerifyDate {
		
    @isTest static void testSetEndOfMonthDate(){
        //create a Date 
        Date date1=date.newInstance(2000,3,26);
        Date returnedLastDate=VerifyDate.SetEndOfMonthDate(date1);
        System.assertEquals(date.newInstance(2000,3,31),returnedLastDate,'Date is not last date of month');
    }
    
    @isTest static void testDateWithin30Days(){
        Date date1=date.newInstance(2024,5,2);
        Date date2=date.newInstance(2024,5,1);
        Date date3=date.newInstance(2024,6,28);
        Date date4=date.newInstance(2024,5,28);
        System.assertEquals(false,VerifyDate.DateWithin30Days(date1, date2));
        System.assertEquals(false,VerifyDate.DateWithin30Days(date1, date3));
        System.assertEquals(true,VerifyDate.DateWithin30Days(date1, date4));
        
        Date case1Date=VerifyDate.CheckDates(date1, date4);
        System.assertEquals(date4,case1Date);
        System.assertEquals(date.newInstance(2024,5,31),VerifyDate.CheckDates(date1, date3));
    }
    
}