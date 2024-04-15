public class VerifyDate {
	
    public static Date CheckDates(Date date1, Date date2){
        if(DateWithin30Days(date1,date2))
            return date2;
        else 
            return SetEndOfMonthDate(date1);
    }
    
    
    @TestVisible
    private static Boolean DateWithin30Days(Date date1, Date date2){
        //check if the date 2 being in past 
        if(date2<date1 )
            return false;
        //check if the date 2 is within .= 30 days of date 1 
        Date date30Days= date1.addDays(30);//create a date 30 days awaya from the date 1 
        if(date2>=date30Days)
            return false;
        else 
            return true;
    }
    
    @TestVisible
    private static Date SetEndOfMonthDate(Date date1){
        Integer totalDays=Date.daysInMonth(date1.year(), date1.month());
        Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
        return lastDay;
    }
}