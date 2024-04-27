import { LightningElement,wire,api,track  } from 'lwc';

export default class LDS_1_GetRecordIdAndObjectApiNameDEMO extends LightningElement {
    @api recordId;/*To get the Record Id*/
    @api objectApiName; /*Ex:  Account , Opportuniuty  */

    constructor() { 
        super();
        console.log('Record Id :' + this.recordId);
        console.log('Object api name : ' + this.objectApiName);
    }
}