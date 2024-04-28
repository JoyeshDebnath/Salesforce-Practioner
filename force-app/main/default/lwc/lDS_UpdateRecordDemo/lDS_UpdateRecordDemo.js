import { LightningElement ,wire,api} from 'lwc';
import { updateRecord,getRecord,getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT from '@salesforce/schema/Account';
//fields 
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import ID_FIELD from '@salesforce/schema/Contact.Id';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';


const FIELDS = [FIRSTNAME_FIELD, LASTNAME_FIELD, ID_FIELD, EMAIL_FIELD];

export default class LDS_UpdateRecordDemo extends LightningElement {
    @api recordId;
    contactRecord;
    __error;
    fieldValues = {};


    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredContact ({ data, error }) { 
        if (data)
        {
            this.contactRecord = data;
            console.log("Data =" + JSON.stringify(data));
        }
        else if (error)
        { 
            this.__error = error;
        }
    }

    get firstname () { 
        return getFieldValue(this.contactRecord, FIRSTNAME_FIELD);
    }
    get lastname () { 
        return getFieldValue(this.contactRecord, LASTNAME_FIELD);

    }
    get id () { 
        return getFieldValue(this.contactRecord, ID_FIELD);
    }
    get email () { 
        return getFieldValue(this.contactRecord, EMAIL_FIELD);
    }

    handleChange (event) { 
        console.log("Event Target...",event.target)
        event.preventDefault();
        console.log('event.target.name=' + event.target.name);
        let name = event.target.name;
        let value = event.target.value;
        console.log('event.target.name=' + event.target.value);
        this.fieldValues[name] = value;
        console.log('This.FieldValues=' + this.fieldValues);
    }


    handleUpdate (event) { 
        console.log('clicked ')
        event.preventDefault();
        let fields = {};
        console.log('this.fieldValues===' + this.fieldValues);
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[FIRSTNAME_FIELD.fieldApiName] = this.fieldValues.FirstName;
        fields[LASTNAME_FIELD.fieldApiName] = this.fieldValues.LastName;
        fields[EMAIL_FIELD.fieldApiName] = this.fieldValues.Email;
        const recordInput = { fields };

alert('updateing record ...')
        //update record
        updateRecord(recordInput)
            .then(() => { 
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'success Creating Record',
                        variant: 'success',
                        message:'Contact updated !'
                    })
                )
            }).catch(error => { 
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error Creating record ',
                        message: 'Something went wrong ',
                        variant:'error'
                    })
                )
            })
    }
}