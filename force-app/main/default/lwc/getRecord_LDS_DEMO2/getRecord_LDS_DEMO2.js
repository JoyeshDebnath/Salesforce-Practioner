/**
 * 
 * 
 */

import { LightningElement,wire,api } from 'lwc';
import {getRecord,getFieldValue} from 'lightning/uiRecordApi';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import OWNER_FIELD from '@salesforce/schema/Account.Owner.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

const FIELDS=['Account.Type',NAME_FIELD,OWNER_FIELD,PHONE_FIELD,INDUSTRY_FIELD];

export default class GetRecord_LDS_DEMO2 extends LightningElement {
    @api recordId;
    accountRecord;

    @wire(getRecord,{
        recordId:'$recordId',
        modes:['Edit','View','Create'],
        layoutTypes:['Compact','Full']
    })
    wiredAccount({data,error}){
        if(data){
            this.accountRecord=data;
        }if(error){
            console.log(error);
        }
    }

    get name(){
        return getFieldValue(this.accountRecord,NAME_FIELD);
    }
    get phone(){
        return getFieldValue(this.accountRecord,PHONE_FIELD);
    }
    get industry(){
        return getFieldValue(this.accountRecord,INDUSTRY_FIELD);
    }
    get owner(){
        return getFieldValue(this.accountRecord,OWNER_FIELD);
    }
    get type(){
        return getFieldValue(this.accountRecord,'Account.Type');
    }
}