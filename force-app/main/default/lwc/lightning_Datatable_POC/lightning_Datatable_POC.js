import { LightningElement,wire,api,track } from 'lwc';
import getContactsDetails from '@salesforce/apex/DatatablePOC_Controller.getContactList';


export default class Lightning_Datatable_POC extends LightningElement {

    contactsDatae = [];

    @wire(getContactsDetails)
    contactDetailWireResponse ({ datae, error }) { 
        if (data)
        { 
            this.contactsData = JSON.parse(JSON.stringify(data));
            console.log("Contacts Data fetched .."+this.contactsData);
        }
        if (error)
        { 
            console.log(error);
        }
    }
}