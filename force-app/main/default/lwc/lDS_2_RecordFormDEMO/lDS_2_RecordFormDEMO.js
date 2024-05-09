import { LightningElement,wire,api } from 'lwc';

export default class LDS_2_RecordFormDEMO extends LightningElement {
    @api recordId;
    @api objectApiName;

    constructor() { 
        super();
        console.log('njd',this.recordId,this.objectApiName)
    }
}