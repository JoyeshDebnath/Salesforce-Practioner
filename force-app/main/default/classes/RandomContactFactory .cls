public  class ContactTestFactory {
    public static List<Contact> createContacts(integer numOfContacts,String lastName){
        List<Contact> conList=new List<Contact>();
        for(integer i=0;i<numOfContacts;i++){
                    conList.add(
                        new Contact(
                            FirstName='test'+i,
                            LastName=lastName
                        )
                    );
        }
        return conList;
    }
}