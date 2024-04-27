import { LightningElement,api } from 'lwc';

export default class LDS_3_EditRecordDemo extends LightningElement {
    @api recordId;
    @api objectApiName;

    saveHandler (event) { 
        //save form logic 
    }

}