public class Priority {
  
    public static string getPriority(String leadState){
        
        if(String.isBlank(leadstate) || leadState.length()>2)
            return null;
        
        String taskPriority='';
        if(leadState=='CA')
            taskPriority='High';
        else
            taskPriority='Normal';
        
        return taskPriority;
        
    }
}