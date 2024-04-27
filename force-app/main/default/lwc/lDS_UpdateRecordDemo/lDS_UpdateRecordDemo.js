import { LightningElement ,wire,api} from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT from '@salesforce/schema/Account';
//fields 
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import ID_FIELD from '@salesforce/schema/Contact.Id';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';



export default class LDS_UpdateRecordDemo extends LightningElement {
    @api recordId;

    handleUpdate (event) { 
        console.log('clicked ')
        event.preventDefault();
        let fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[FIRSTNAME_FIELD.fieldApiName] = 'LWC';
        fields[LASTNAME_FIELD.fieldApiName] = 'Update Record';
        fields[EMAIL_FIELD.fieldApiName] = 'SFDC@gmail.com';
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
                        message: error.body.message,
                        variant:'error'
                    })
                )
            })
    }
}