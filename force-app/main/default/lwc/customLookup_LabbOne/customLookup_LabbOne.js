import { LightningElement,api,track,wire } from 'lwc';
import fetchRecords from '@salesforce/apex/LookUpControllerLWC.findRecords';

export default class CustomLookup_LabbOne extends LightningElement {
    @api objectApiName='Account';//dynamic object 
    @api fieldApiName='Name';//dyna,mic field 
    @api iconName='standard:account';//dynamic icon 
    @track records;
    @track errors;
    //selected record 
    @track selectedRecord;

    

    handleSearch (event) { 
        const searchVal = event.detail;
        fetchRecords({
            objectname: this.objectApiName,
            searchVal: searchVal,
            fieldApiName:this.fieldApiName
        })
            .then(res => { 
                // console.log(res);
                this.records = res;
                this.errors = undefined;
            })
            .catch(err => { 
                console.log(err);
                this.errors = err.getMessage();
                this.records = undefined;
            })
    }

    handleSelect (event) { 
        const selectedRecordId = event.detail;

        const selectedRecord = this.records.find(rec => rec.Id == selectedRecordId);
        this.selectedRecord=selectedRecord;
    }

    handleRemove (event) { 
        this.selectedRecord = undefined;
        this.errors = undefined;
        this.records=undefined;
    }
}