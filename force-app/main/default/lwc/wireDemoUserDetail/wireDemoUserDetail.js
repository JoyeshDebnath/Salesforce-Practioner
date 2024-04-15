import { LightningElement ,wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';

import Id from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name'
import EMAIL_FIELD from '@salesforce/schema/User.Email'

const fields=[NAME_FIELD, EMAIL_FIELD];
export default class WireDemoUserDetail extends LightningElement {
    userId=Id;
    userDetails;
    //0055j000007NYIrAAO

    //~~~~~fetch user details 
    
    //@wire(adapter,{adapterConfig})
    //propertyorfunction
    @wire(getRecord,{recordId:'0055j000007NYIrAAO',fields})
    userDetailsHandler({data,error}){
        // console.log(response);
        if(data){
                this.userDetails=data.fields;
        }
        if(error){
            console.log(error)
        }
    }

    @wire(getRecord,{recordId:'0055j000007NYIrAAO',fields:['User.Name','User.Email']})
    userDetailsProperty
     
}