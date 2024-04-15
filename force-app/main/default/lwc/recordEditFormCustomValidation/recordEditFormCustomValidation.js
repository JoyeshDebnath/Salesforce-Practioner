import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RecordEditFormCustomValidation extends LightningElement {
    objectName = ACCOUNT_OBJECT;
    inputValue='';

    handleChange (event) { 
        this.inputValue = event.target.value;

    }

    handleSubmit (event) { 
        event.preventDefault();
        const inputField = this.template.querySelector('lightning-input')
        const val = inputField.value;
        if (!val.includes('Japan'))
        {
            inputField.setCustomValidity("The Account name must include 'Japan' !");
        } else
        { 
            inputField.setCustomValidity('');
            const fields = event.detail.fields;
            fields.Name = val;
            this.template.querySelector('lightning-record-edit-form').submit(fields);
        }
        inputField.reportValidity();
    }

    successHandler (event) { 
        // event.preventDefault();
        const successToastEvent=new ShowToastEvent({
            title: 'Account Created !',
            message: 'record Id : ' + event.detail.id,
            variant:'success'
        })
        this.dispatchEvent(successToastEvent)

    }

    handleError (event) { 
        const toastEvent = new ShowToastEvent({
            title: 'Something went Wrong !',
            message: event.detail.message,
            variant:"error"
        })
        this.dispatchEvent(toastEvent);
    }
}