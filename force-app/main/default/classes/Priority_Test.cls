@isTest
public class Priority_Test {
   
    @isTest
    static void testGetPriority(){
        String pri = Priority.getPriority('NY');
        System.assertEquals('Normal', pri);
    }
    @isTest
    static void testHighPriority(){
        String pri2 = Priority.getPriority('CA');
        System.assertEquals('High', pri2);
    }
    
    @isTest
    static void testInvalidInputForPriority(){
        String pri3 = Priority.getPriority('Montana');
        System.assertEquals(null, pri3);
    }
}