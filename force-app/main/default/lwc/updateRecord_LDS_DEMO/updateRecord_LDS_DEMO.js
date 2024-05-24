import { LightningElement,wire,api } from 'lwc';
import {updateRecord,getRecord,getFieldValue} from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

import ID_FIELD from '@salesforce/schema/Contact.Id';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

const FIELDS=[ID_FIELD,FIRST_NAME_FIELD,LAST_NAME_FIELD,EMAIL_FIELD];

export default class UpdateRecord_LDS_DEMO extends LightningElement {
@api recordId;
contactsData;
fieldValues={};

    //get records info 
    @wire(getRecord,{
        recordId:'$recordId',
        modes:['View','Edit','Create'],
        layoutTypes:['Compact','Full'],

    })
    wiredContactResponse({data,error}){
        if(data){
            this.contactsData=data;
        }
        if(error){
            console.log(error);
        }
    } 

    get firstName(){
        return getFieldValue(this.contactsData,FIRST_NAME_FIELD);
    }
    get lastName(){
        return getFieldValue(this.contactsData,LAST_NAME_FIELD);
    }
    get email(){
        return getFieldValue(this.contactsData,EMAIL_FIELD);
    }


    handleUpdate(event){
        event.preventDefault();
        let fields={};
        fields[ID_FIELD.fieldApiName]=this.recordId;
        fields[FIRST_NAME_FIELD.fieldApiName]=this.fieldValues.FirstName;
        fields[LAST_NAME_FIELD.fieldApiName]=this.fieldValues.LastName;
        fields[EMAIL_FIELD.fieldApiName]=this.fieldValues.Email;
        const recordInput={fields};

        //update 
        updateRecord(recordInput)
        .then((res)=>{
            const UpdateEvent = new ShowToastEvent({
            title: 'Update SuccessFul !',
            message:
                'Record Updated :'+res.Id,
            variant:'success',
        });
        this.dispatchEvent(UpdateEvent);
        })
        .catch(err=>{
            const UpdateFailEvent = new ShowToastEvent({
            title: 'Update Failed',
            message:
                'Error Ocurred ',
            variant:'error',
        });
        this.dispatchEvent(UpdateFailEvent);
        })
    }

    handleChange(event){
        event.preventDefault();
        let name=event.target.name;
        let value=event.target.value;
        this.fieldValues[name]=value;

    }
}