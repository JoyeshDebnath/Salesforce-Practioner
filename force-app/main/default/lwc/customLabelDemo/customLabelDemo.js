import { LightningElement,api,wire,track } from 'lwc';
import getStateRecords from '@salesforce/apex/CustomMetadataController.getStateRecords';


export default class CustomLabelDemo extends LightningElement {

    @track labels = [];

    @wire(getStateRecords)
    stateRecordResponse ({ data, error }) { 
        if (data)
        {
            console.log('Response of custom meatadata ..', data);
            this.labels = data;
        }
        else if (error)
        { 
            console.log(error);
        }
    }
}