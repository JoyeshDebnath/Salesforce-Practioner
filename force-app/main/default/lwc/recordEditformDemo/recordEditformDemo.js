import { LightningElement,api } from 'lwc';
import CONTACT from '@salesforce/schema/Contact'
import NAME from '@salesforce/schema/Contact.Name';
// import NAME from '@salesforce/schema/Contact.Name';
import TITLE from '@salesforce/schema/Contact.Title';
import PHONE from '@salesforce/schema/Contact.Phone';
import EMAIL from '@salesforce/schema/Contact.Email';
import ACCOUNT_FIELD from '@salesforce/schema/Contact.AccountId';

export default class RecordEditformDemo extends LightningElement {
    objectName = CONTACT;
    // fieldList = [NAME, PHONE, TITLE, EMAIL];
    fieldList = {
        accountField:ACCOUNT_FIELD,
        contactName: NAME,
        contactPhone: PHONE,
        contactTitle: TITLE,
        contactEmail:EMAIL
    }

    resetEditForm () { 
        const inputFields = this.template.querySelectorAll('lightning-input-field');
        if (inputFields)
        {
            Array.from(inputFields).forEach(field => {
                field.reset();
            })
        }
    }

    // get fields () { 
    //     return Object.entries(this.objectList).map(([key, value]) => ({ key, value }));
    // }

}