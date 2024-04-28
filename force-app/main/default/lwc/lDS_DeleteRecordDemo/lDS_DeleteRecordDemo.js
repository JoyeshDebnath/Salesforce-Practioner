import { LightningElement,api,wire } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';

import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LDS_DeleteRecordDemo extends LightningElement {
    @api recordId;
    @api objectApiName;

    handleDelete (event) {
        deleteRecord(this.recordId)
            .then(() => { 
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record Deleted SuccessFully!',
                        variant:'success'
                    })
                )
                
                this[NavigationMixin.Navigate]({
                    type: 'standard__objectPage',
                    attributes: {
                        actionName: 'home',
                        objectApiName:this.objectApiName
                    }
                })
            })
            .catch((error) => { 
                console.log(error)
            })
        
    }

}