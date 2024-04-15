import { LightningElement,api } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME from '@salesforce/schema/Account.Name';
import REV from '@salesforce/schema/Account.AnnualRevenue';
import TYPE from '@salesforce/schema/Account.Type';
import INDUSTRY from '@salesforce/schema/Account.Industry';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class LightningRecordFormDemo extends LightningElement {
    
    @api recordId;
    @api objectApiName;
    
    objectName = ACCOUNT_OBJECT;
    fieldList = [NAME, REV, TYPE, INDUSTRY];
    
    successHandler (event) { 
        console.log(event.detail.id);
        const toastEvent = new ShowToastEvent({
            title: 'Account Created',
            message: 'Record Id : ' + event.detail.id,
            variant: 'success'
        });
        this.dispatchEvent(toastEvent);
    }
}