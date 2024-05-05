import { LightningElement,wire,api } from 'lwc';
import getContactData from '@salesforce/apex/ContactController.getContactsBasedOnAccount';

import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const columns = [
    { label: 'Name', fieldName:"Name",editable:true },
    { label: 'Email', fieldName: "Email",type:'Email',editable:true },
    { label: 'Phone', fieldName: "Phone", type: 'Phone', editable: true },
    { label: 'Title', fieldName: "Title",editable:true },
    { label: 'Account Name', fieldName: "accountName" },
    
    
]
export default class EditableDatableDemo extends LightningElement {
    @api recordId;
    contacts = [];
    _error;
    columns = columns;
    draftValues = [];
    contactRefreshProp;
        
    @wire(getContactData, {
        AccountId: '$recordId'
    })
    contactsWireResponse (res) { 
        this.contactRefreshProp = res;
        if (res.data)
        { 
            this.contacts = JSON.parse(JSON.stringify(res.data));
            console.log('Data \n', res.data);
            this.contacts = this.contacts.map(contact => { 

                let accountName = contact.Account.Name;
                return {
                    ...contact,
                    accountName
                }
            })
        } if (res.error)
        { 
            this._error = res.error;
            console.log(this._error);
        }
    }


    async handleSave (event) { 
        //To save the record We have two options 
        //option 1> use the UpdateRecord adapter
        //option 2> Use the Apex Method
        
        //access the draft values 
        let records = event.detail.draftValues;//array of modified records 
        let updateRecordsArray = records.map(item => { 
            console.log('Item : ',item)
            let fieldInput = { ...item }
            return {
                fields:fieldInput,
            }
}
        )
        console.log('after midify:', JSON.stringify(updateRecordsArray)
        )
        this.draftValues = [];
        let updateRecordPromise = updateRecordsArray.map(currItem => {
            console.log("curr Item", JSON.stringify(currItem))
            try
            {
                updateRecord(currItem)
            } catch (e)
            { 
                console.log(e.getMessage())
            }
        }
        );
        await Promise.all(updateRecordPromise);//resolve all the promises 

        //display succcess message 
        const  toastEvent = new ShowToastEvent(
            {
                title: 'Success',
                message: 'Recods Updated Succesfully !',
                variant:'success'
            }
        )
        this.dispatchEvent(toastEvent);

        await refreshApex(this.contactRefreshProp);
    }
}