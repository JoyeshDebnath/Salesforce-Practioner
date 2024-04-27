import { LightningElement ,wire,api} from 'lwc';
import { getRecord, createRecord ,getFieldValue} from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
//Fields 
import NAME_FIELD from '@salesforce/schema/Account.Name';
import OWNER_NAME_FIELD from '@salesforce/schema/Account.Owner.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

const FIELDS = ['Account.Type',NAME_FIELD,INDUSTRY_FIELD,OWNER_NAME_FIELD,INDUSTRY_FIELD];

export default class LDS_4_UIRecordDemo extends LightningElement {

    @api recordId
    @api objectApiName
    accountRecord;
    __error;


    //get record 
    @wire(getRecord, {
        recordId: '$recordId',
        layoutTypes: ['Full', 'Compact'],
        modes: ['View', 'Edit', 'Create'],
        
    })
    wiredRecord ({ data, error }) {
        if (data)
        {
            console.log('Record Information :', data);
            const industry = data.fields.Industry.value;
            console.log('Industry : '+industry);
        }
        else if (error)
        {
            console.log('Record error:', error)
        }
    }

    //create Record Demo using Record ui 
    handleCreate () { 
        const fields = {};
        console.log("NAME_FIELD : " +JSON.stringify( NAME_FIELD),NAME_FIELD.fieldApiName);
        fields[NAME_FIELD.fieldApiName] = 'SFDC JD';
        console.log("ACCOUNT_OBJECT :   " + JSON.stringify(ACCOUNT_OBJECT),ACCOUNT_OBJECT.objectApiName);
        const accountRecord = { apiName:ACCOUNT_OBJECT.objectApiName, fields: fields };

        createRecord(accountRecord).then(result => { 
            console.log("result: ",result);
            const id = result.id;
            alert('Record Created !'+id);
        }).catch(error => { 
                console.log(error)
        })

    }

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredAccount ({ data, error }) { 
        if (data)
        {
            console.log('Data fetched :' + JSON.stringify(data));
            this.accountRecord = data;
        } else if (error)
        { 
            console.log('Error Occurred :' + error);
            this.__error = error;
        }
    }

    //getter methods to access the fields 
    get name () { 
        return getFieldValue(this.accountRecord, NAME_FIELD);
    }

    get phone () { 
        return getFieldValue(this.accountRecord, PHONE_FIELD);
    }
    get industry () { 
        return getFieldValue(this.accountRecord, INDUSTRY_FIELD);
    }
    get owner () { 
        return getFieldValue(this.accountRecord,OWNER_NAME_FIELD )
    }
    get typeWF () { 
        let value = '';
        if (this.accountRecord)
        { 
            value = this.accountRecord.fields.Type.value;
        }
        return value;
    }

    get type () { 
        return getFieldValue(this.accountRecord, 'Account.Type')
    }




}