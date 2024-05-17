//Default record Type id that salesforce provides us :-->>                      012000000000000AAA

import { LightningElement,wire,api } from 'lwc';
import { getPicklistValues,getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
// import ACCOUNT_OBJECT from '@salesforce/schema/Account';
// import ACCOUNT_SOURCE_FIELD from '@salesforce/schema/Account.AccountSource';
const DEFAULT_RECORD_TYPE_ID = '012000000000000AAA';


export default class PicklistComponentDemo extends LightningElement {
    @api recordTypeId = DEFAULT_RECORD_TYPE_ID;
    @api objectApiName = 'Account';
    @api fieldApiName = 'Type';

    acntSrc;
    options=[];
    
    // @wire(getPicklistValues, {
    //     recordTypeId: '$recordTypeId',
    //     fieldApiName: ACCOUNT_SOURCE_FIELD
    // })
    // wiredPicklist ({ data, error }) {
    //     if (data)
    //     {
    //         console.log("Picklist Data fetched .. \n", data.values);
    //         this.options=data.values.map(currItem => {
    //             return {
    //                 'label': currItem.label,
    //                 'value':currItem.value
    //             }
    //         })
    //     }
    //     else if (error)
    //     {
    //         console.log(error)
    //     }
    // }
    
    @wire(getPicklistValuesByRecordType, {
        recordTypeId: '$recordTypeId',
        objectApiName: '$objectApiName'
    })
    wiredPicklist ({ data, error }) { 
        if (data)
        {
            console.log("Picklist Data fetched .. \n", data);
            if (data.picklistFieldValues && data.picklistFieldValues[this.fieldApiName])
            { 
                let picklistValues = data.picklistFieldValues[this.fieldApiName];
                this.options = picklistValues.values;
            }
        }
        else if (error)
        { 
            console.log(error)
        }
    }
    handleChange (event) { 
        this.acntSrc = event.target.value;
    }
}