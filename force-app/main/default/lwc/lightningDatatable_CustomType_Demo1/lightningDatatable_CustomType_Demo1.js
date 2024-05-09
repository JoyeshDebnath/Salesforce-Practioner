import { LightningElement,wire,api } from 'lwc';
import getContactsData from '@salesforce/apex/ContactController.getContactData'
const columns=[
    { label: 'Name', fieldName: 'name' },
    { label: 'Title', fieldName: 'Title' ,
        cellAttributes:{
            class:{
                fieldName:'greenText'
            }
        }
    },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Picture', fieldName: 'Picture__c', type: 'url' },
    { label: 'Rank', fieldName: 'Rank__c', type: 'number' },
    { label: 'Account name', fieldName: 'accountLink', type: 'url',
        typeAttributes:{
            label:{
                fieldName:"accountName"
            },
            target:'_blank'
        },
        
     },
    
]

export default class LightningDatatable_CustomType_Demo1 extends LightningElement {

    contactsData=[];
    _error;
    columns=columns;

    @wire(getContactsData)
    contactsWiredResponse({data,error}){
        if(data){
            
            this.contactsData=JSON.parse(JSON.stringify(data));
            this.contactsData=this.contactsData.map(currContact=>{
                    let accountName=currContact.Account.Name;
                    let accountLink='/'+currContact.AccountId;
                    let greenText="slds-text-color_success";
                    let redText='slds-text-color_error'
                    return {
                        ...currContact,
                        accountName,
                        accountLink,
                        greenText,
                        redText
                    }
            })
        }
        else if(error){
            this._error=error;
        }
    }
}