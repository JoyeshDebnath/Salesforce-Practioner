import { LightningElement,wire } from 'lwc';
import { getObjectInfo,getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account'

export default class GetPicklistValuesByRecordTypeDemo extends LightningElement {
    ratingOptions=[];
    industryOptions=[];
    selectedIndustry='';
    selectedRating='';

    @wire(getObjectInfo , { objectApiName: ACCOUNT_OBJECT })
    accountObjectInfo

    @wire(getPicklistValuesByRecordType , {objectApiName:ACCOUNT_OBJECT, recordTypeId:'$accountObjectInfo.data.defaultRecordTypeId'})
        accountPickListHandler({data,error}){
            if(data){
                // console.log("All pick lists ...",data)
                this.ratingOptions=[...this.generatePickListOptions(data.picklistFieldValues.Rating)];
                this.industryOptions=[...this.generatePickListOptions(data.picklistFieldValues.Industry)];
                // 
                this.selectedRating=this.ratingOptions[0].value;
                this.selectedIndustry=this.industryOptions[0].value;

            }
            if(error){
                console.log(error)
            }
        }

    generatePickListOptions(data){
        return data.values.map(item=>({"label":item.label,"value":item.value}))
    }

    handleRatingChange(event){
        this.selectedRating=event.detail.value;
    }

    handleIndustryChange(event){
        this.selectedIndustry=event.detail.value;
    }
}