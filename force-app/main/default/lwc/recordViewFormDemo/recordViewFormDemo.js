import { LightningElement,api } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_NUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import RATING_FIELD from '@salesforce/schema/Account.Rating';

export default class RecordViewFormDemo extends LightningElement {
    recordId = '0015j00001AD7JYAA1';
    objectName = ACCOUNT_OBJECT;

    fieldList = [NAME_FIELD, ACCOUNT_NUMBER_FIELD, RATING_FIELD];
    
}