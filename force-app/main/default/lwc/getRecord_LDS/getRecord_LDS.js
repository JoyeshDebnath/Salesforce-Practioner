/**
 * get Record *
 * Create record DEMO 
 */


import { LightningElement,wire,api } from 'lwc';
import {getRecord,createRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

import NAME_FIELD from '@salesforce/schema/Account.Name';


export default class GetRecord_LDS extends LightningElement {
    @api recordId;

    @wire(getRecord,{
        recordId:'$recordId',
        layoutTypes:['Full','Compact'],
        mode:['View','Edit','Create']
    })
    wiredRecord({data,error}){
        if(data){
            console.log('Record Information : \n',data);
            const company=data.fields.Company.value;

        }
        if(error){
            console.log(error);
        }
    }

    handleCreate(){
        let fields={};
        console.log(NAME_FIELD.fieldApiName,ACCOUNT_OBJECT.objectApiName);
        fields[NAME_FIELD.fieldApiName]='Joyesh Debnath';
        let accountRecord={
            apiName:ACCOUNT_OBJECT.objectApiName,
            fields:fields,
        }

        createRecord(accountRecord)
        .then((result)=>{
            const id=result.Id;
            const event = new ShowToastEvent({
            title: 'Record Created ',
            message:
                'Record with Id;'+id+' is created !',
            variant:'success'
        });
        this.dispatchEvent(event);

        }).catch(err=>{
            console.log(err)
            const event = new ShowToastEvent({
            title: 'Something Went Wrong ',
            message:
                'Something went wrong',
            variant:'error'
        });
        this.dispatchEvent(event);
        })
    }
}