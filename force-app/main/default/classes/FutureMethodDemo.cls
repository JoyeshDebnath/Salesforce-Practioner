public with sharing class FutureMethodDemo {
    public static void run(){

    }

    public static void createUser(){
        UserRole role=[SELECT Id FROM UserRole WHERE Name='Joyesh' LIMIT 1 ];
        
    }
}