import { LightningElement,wire } from 'lwc';
import {getObjectInfo} from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';//get the reference of the object 
export default class GetObjectInfoDemo extends LightningElement {
    defaultRecordTypeID;

    @wire(getObjectInfo,{objectApiName:ACCOUNT_OBJECT})
    obJectInfo({data,error}){
        if(data){
            this.defaultRecordTypeID=data.defaultRecordTypeId;
            console.log("DATA",data)
            console.log(this.defaultRecordTypeID)
        }
        if(error){
            console.log(error)
        }
    }
}