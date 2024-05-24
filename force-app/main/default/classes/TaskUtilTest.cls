@isTest
public class TaskUtilTest {
    @isTest public static void testTaskPriority(){
        String pri=TaskUtil.getTaskPriority('NY');
        System.assertEquals('Normal', pri,'Soemthing is wrong !');
    }
    
    @isTest public static void testTaskPriorityHigh(){
        String pri=TaskUtil.getTaskPriority('CA');
        System.assertEquals('High', pri,'Soemthing is wrong !');
    }

    @isTest public static void testTaskPriorityInvalid(){
        String pri=TaskUtil.getTaskPriority('Joyesh');
        System.assertEquals(null, pri,'Soemthing is wrong !');
    }
}