import { LightningElement,wire,api } from 'lwc';
import getContactsData from '@salesforce/apex/ContactController.getContactData'
const columns=[
    { label: 'Name', type:"customName" ,typeAttributes:{
        contactName:{
            fieldName:"Name"
        }
    }
    },
    { label: 'Title', fieldName: 'Title' ,
        cellAttributes:{
            class:{
                fieldName:'greenText'
            }
        }
    },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Picture',  type: 'customPicture',
            typeAttributes:{
                pictureUrl:{
                    fieldName:"Picture__c"
                }
            },
            cellAttributes:{
                alignment:"center"
            }
     },
    { label: 'Rank', fieldName: 'Rank__c', type: 'customRank',
        typeAttributes:{
            rankIcon:{
                fieldName:"rankIcon"
            }
        }
     },
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
                    let rankIcon=currContact.Rank__c>5?'utility:ribbon':'';
                    return {
                        ...currContact,
                        accountName,
                        accountLink,
                        greenText,
                        redText,
                        rankIcon
                    }
            })
        }
        else if(error){
            this._error=error;
        }
    }
}