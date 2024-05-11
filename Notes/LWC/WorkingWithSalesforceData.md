## RefreshApex in LWC
- in order to refresh the lwc page data we use refreshapex 
- This only works in case of Wire data 
- To refresh the data we have 2 ways : 
    1. Call Apex method again 
    2. using refresh Apex method 
- import {refreshApex} from '@salesforce/apex';
  
  
  ## UI Record API 
  used in following cases : 
  - get Record 
  - Get Field Value 
  - Create Record 
  - Delete Record 
  - Update Record 
  
  Syntax of **GetRecord**
  ```js
  import getRecord from 'lightning/uiRecordApi';

  @wire(getRecord, {recordId:string,layoutTypes:string[],modes?:string[],optionalFields?:string[],fields:string[]})
  propertyOrFunction

  ```

  ### create Record Syntax 

  ```js
  const fields={};
  fields[NAME_FIELD.fieldApiName]=this.name;
  const recordInput={
    apiName:ACCOUNT_OBECT.objectApiName,fields
  };

  createRecord(recordInput) function 
  ```

  ## Get record and getFieldValues 

  Syntax 
  ```js

  @wire(getRecord,{
    recordId:string,
    fields:string|string[],
    optionalFields:string|string[],
    layoutTypes:['Compact','Full'],
    modes:['view','Create','Edit'],

  })
  propertyORfunction 

  get phone(){
    return  getFieldValue(this.account.data,PHONE_FIELD)
  }
  ```

  ## Update Record in LWC 

  Syntax 👍
  
  ```js

  const fields={};
  fields[ID_FIELD.fieldApiName]=this.recordId;
  fields[FIRST_NAME_FIELD.fieldApiName]='Joyesh';
  fields[LAST_NAME_FIELD.fieldApiName]='Debnath';
  fields[EMAIL_ID_FIELD.fieldApiName]='sfdc@gmail.com';

  const recordInput={fields};
  
  updateRecord(recordInput)
  .then((res)=>{})
  .catch(err=>{})
  .finally(()=>{})
  ```