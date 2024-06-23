public  class RandomContactFactory {
    public static List<Contact> generateRandomContacts (integer numOfContacts,String lastName){
        List<Contact> conList=new List<Contact>();
        for(integer i=0;i<numOfContacts;i++){
                    conList.add(
                        new Contact(
                            FirstName='Test '+i,
                            LastName=lastName
                        )
                    );
        }
        return conList;
    }
}