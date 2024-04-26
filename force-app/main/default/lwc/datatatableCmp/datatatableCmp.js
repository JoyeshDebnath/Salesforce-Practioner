import { LightningElement,wire,api,track } from 'lwc';
import fetchContactData from '@salesforce/apex/datatableController.fetchContactData';
//columns 
//fieldName -->> api name of tha data 
const columns = [
    {
        label: "Id", fieldName: "Id", type: "text"},
    {
        label: "Name", fieldName: "recordUrl", type: "url",
        typeAttributes: {
            label: {
                fieldName: "Name",
            },
            target:'_blank'
        },
        cellAttributes: {
            iconName: {
                fieldName: "contactIcon"
            },
            iconPosition: 'left',
            iconAlternativeText:'Contact Icon'
        }
    },
    {label:'Phone',fieldName:'Phone',type:'phone'},
    { label: 'Title', fieldName: 'Title', type: 'text' },
    { label: 'AccountId', fieldName: 'AccountId', type: 'text' },
    { label: 'Email', fieldName: 'Email', type: 'Email' },
    {
        label: 'Account_Name', fieldName: 'accountUrl', type: 'url',
        typeAttributes: {
            label: {
                fieldName: "ACCOUNT_NAME",
            },
        target:'_blank'
        },
        cellAttributes: {
            iconName: {
                fieldName:'accountIcon',
            },
            iconPosition: 'right',
            iconAlternativeText:'Account Icon'
        }
    }
]

export default class DatatatableCmp extends LightningElement {
    contactData;
    columnList = columns;
    error;

    @wire(fetchContactData)
    contactResponse ({ data, error }) { 
        if (data)
        {
            let paresedData = JSON.parse(JSON.stringify(data));
            let baseUrl = 'https://' + location.host + '/';//salesforce org base url 
            paresedData.forEach(contact => {
                if (contact.AccountId)
                {
                    contact.ACCOUNT_NAME = contact.Account.Name;
                    contact.recordUrl = baseUrl + contact.Id;//url for contact record 
                    contact.accountUrl = baseUrl + contact.AccountId;//account id base url 
                    contact.accountIcon = 'standard:account';
                    contact.contactIcon = 'standard:contact';
                }
            });
            console.log(data);
            this.contactData = paresedData;
        }
        else if (error)
        { 
            this.error=error
        }
    }
}