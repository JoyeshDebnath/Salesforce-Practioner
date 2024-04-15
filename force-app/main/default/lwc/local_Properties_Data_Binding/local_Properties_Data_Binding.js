/*
    data binding 
    methods 
    two way data binding 

*/


import { LightningElement,track } from 'lwc';

export default class Local_Properties_Data_Binding extends LightningElement {
    name = 'Joyesh Debnath';
    title = 'Salesforce Admin';

    address = {
        country: 'India',
        city: 'Bangaluru',
        zipCode:'80098'
    }
    
    titleChangeHandler (event) { 
        event.preventDefault();
        this.title = event.target.value;
    }
    cityChangeHandler (event) { 
        event.preventDefault();
        this.address = { ...this.address, city: event.target.value };
        
    }

}