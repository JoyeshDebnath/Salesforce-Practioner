import { LightningElement,wire,api } from 'lwc';
import getContactsByAccount from '@salesforce/apex/ContactController.getContactsBasedOnAccount';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';
import {getObjectInfo,getPicklistValues} from 'lightning/uiObjectInfoApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import LEAD_SOURCE from '@salesforce/schema/Contact.LeadSource';


const columns=[
    {label:"First Name",fieldName:"FirstName",editable:true},
    {label:"Last Name",fieldName:"LastName",editable:true},
    {label:"Title",fieldName:"Title",editable:true},
    {label:"Phone",fieldName:"Phone",type:"phone",editable:true},
    {label:"Email",fieldName:"Email",type:"email",editable:true},
    {label:'Lead Source',fieldName:'LeadSource',type:'customPicklist',editable:true,
        typeAttributes:{
                options:{
                    fieldName:'picklistoptions'
                },
                value:{
                    fieldName:'LeadSource'
                },
                context:{
                    fieldName:"Id"
                }
        }
    }
    
]
export default class EditDataTablePoc extends LightningElement {
    @api recordId;
    contactData=[];
    columns=columns;
    draftValues=[];
    contactRefreshProp=[];
    leadSourceOptions=[];


    //get object information to get the record type id to get picklist 
    @wire(getObjectInfo,{
        objectApiName:CONTACT_OBJECT
    })
    objectInfo;

    //get the picklist values 
    @wire(getPicklistValues,{
        recordTypeId:'$objectInfo.data.defaultRecordTypeId',
        fieldApiName:LEAD_SOURCE
    })
    wiredPicklist({data,error}){
        if(data){
                this.leadSourceOptions=data.values;
                console.log('Lead source data ',JSON.stringify(this.leadSourceOptions))
        }if(error){
            console.log(error);
        }
    }

    @wire(getContactsByAccount,{
        AccountId:'$recordId',
        picList:'$leadSourceOptions'
    })
    contactWiredResponse(result){
        this.contactRefreshProp=result;
        if(result.data){
                this.contactData=JSON.parse(JSON.stringify(result.data));
                this.contactData=this.contactData.map(currData=>{
                    let picklistoptions=this.leadSourceOptions;
                   
                    return {
                        ...currData,
                        picklistoptions
                        
                    }
                })
        }if(result.error){
            console.log('Error Ocurred : ',result.error);
        }
    }

    async saveHandler(event){
         let records=event.detail.draftValues; //returns array of modified records 
         let updateRecordsArray=records.map(currItem=>{
             let fieldInput={...currItem};
             return {
                 fields:fieldInput
             }

         })
        this.draftValues=[];
        let updateRecordsPromise=updateRecordsArray.map(currItem=>{
            updateRecord(currItem);
            
        })

        await Promise.all(updateRecordsPromise);
        refreshApex(this.contactRefreshProp);
        const successEvent = new ShowToastEvent({
            title: 'success',
            message:
                'Records Updated Successfully !',
            variant:'success'
        });
        this.dispatchEvent(successEvent);

        

    }
}