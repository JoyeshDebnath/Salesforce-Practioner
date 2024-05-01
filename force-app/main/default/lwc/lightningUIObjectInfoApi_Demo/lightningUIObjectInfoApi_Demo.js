import { LightningElement,api,wire,track } from 'lwc';
import {
    getObjectInfo,
    getPicklistValues
} from 'lightning/uiObjectInfoApi';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import  INDUSTRY_FIELD  from '@salesforce/schema/Account.Industry';
export default class LightningUIObjectInfoApi_Demo extends LightningElement {
    @track value;
    @track pickvalue;

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    wiredAccount ({ data, error }) { 
        if (data)
        {
            console.log("Object Information ..", data);
        }
        else if (error)
        { 
            console.log("Error Ocurred ..", error);
        }
    }

    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: INDUSTRY_FIELD })
    wiredPicklistResponse ({ data, error }) { 
        if (data)
        {
            console.log('Industry picklist data..', data);
            this.pickvalue = data.values;

        }
        else if (error)
        { 
            console.log(error);
        }
    }


}