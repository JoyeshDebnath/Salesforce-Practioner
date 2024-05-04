import { LightningElement,wire,api,track } from 'lwc';
import getContactData from '@salesforce/apex/ContactController.getContactData';

const columns = [
    {
        label: 'Name', type: "customName",
        typeAttributes: {
            contactName: {
                fieldName: "Name"
            }
        }
    },
    {
        label: 'Title', fieldName: 'Title',
        cellAttributes: {
            class: {
                fieldName:'titleColor'
            }
        }
    },
    {
        label: 'Rank', fieldName: 'Rank__c', type: 'customRank', typeAttributes: {
            rankIcon: {
                fieldName: "rankIcon",
            }
            
            
    } },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type:'email'},
    {
        label: 'Picture', fieldName: 'Picture__c', type: 'customPicture',
        typeAttributes: {
            pictureUrl: {
                fieldName:'Picture__c'
            }
        },
        cellAttributes: {
            alignment:"center"
        }
    },
    {
        label: 'Account Name', fieldName: 'accountLink', type: 'url', typeAttributes: {
            label: {
                fieldName:'accountName'
            },
            target:'_blank'
        }
    },

    
];

export default class CustomStyleDataTable extends LightningElement {
    contacts = [];
    _error;
    columns = columns;
    @wire(getContactData)
    wireContactResponse ({ data, error }) {
        if (data)
        {
            this.contacts = JSON.parse(JSON.stringify(data));
            console.log('Data \n', data)
            this.contacts=this.contacts.map(contact => { 
                let accountLink = '/' + contact.AccountId;//creating link.
                let accountName = contact.Account.Name;
                let titleColor = 'slds-text-color_success';
                let rankIcon = contact.Rank__c > 5 ? 'utility:ribbon' : '';
                return {
                    ...contact,
                    accountLink,
                    accountName,
                    titleColor,
                    rankIcon,
                }
            })
        }
        if (error)
        { 
            this._error = error;
        }
    }
}