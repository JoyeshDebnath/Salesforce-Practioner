import { LightningElement,wire } from 'lwc';
import {getObjectInfo, getPicklistValues} from 'lightning/uiObjectInfoApi';
import  ACCOUNT_OBJECT from '@salesforce/schema/Account';
import  ACCOUNT_SOURCE from '@salesforce/schema/Account.AccountSource';
import  CONTACT_OBJECT from '@salesforce/schema/Contact';
import  PRONOUNS from '@salesforce/schema/Contact.Pronouns'; 

export default class GetPicklistValueDemo extends LightningElement {
    selectedAccountSource = 'Web';
    selectedPronoun='Not Listed';
    accountSourceOptions=[];
    pronounsOptions=[];

    @wire(getObjectInfo, { objectApiName:CONTACT_OBJECT})
    contactObjectInfo

    @wire(getObjectInfo ,  {objectApiName: ACCOUNT_OBJECT})
    objectInfo

    @wire(getPicklistValues, { recordTypeId:'$contactObjectInfo.data.defaultRecordTypeId' , fieldApiName:PRONOUNS})
    getPronounsPicklist({data,error}){
        if(data){
            this.pronounsOptions=[...this.generatePickList(data)];  
        }
        if(error){
           console.log(error)
        }
    }


    @wire(getPicklistValues, { recordTypeId:'$objectInfo.data.defaultRecordTypeId' , fieldApiName:ACCOUNT_SOURCE })
    getAccountSourcePicklist({data,error}){
            if(data){
                        this.accountSourceOptions=[...this.generatePickList(data)];
            }
            if(error){
                alert(`Something went Wrong!`)
            }
    }

    //generetae pick list to transformm the data we get 
    generatePickList(data){
        
        return data.values.map((item)=>{
            return { label:item.label , value: item.value}
        })
    }

    // event handlers
    
    handleAccountSourceChange(event) {
        this.selectedAccountSource = event.detail.value;
    }

    handlePronounsChange(event){
        this.selectedPronoun=event.detail.value;
    }
}