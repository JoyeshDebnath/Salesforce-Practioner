import { LightningElement,wire,api } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// objects and fields 
import SUBJECT_FIELD from '@salesforce/schema/Case.Subject';
import DESCRIPTION_FIELD from '@salesforce/schema/Case.Description';

import ORIGIN_FIELD from '@salesforce/schema/Case.Origin';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import PRIORITY_FIELD from '@salesforce/schema/Case.Priority';
import CASE_OBJECT from '@salesforce/schema/Case';
import ACCOUNT_ID_FIELD from '@salesforce/schema/Case.AccountId';
import CONTACT_ID_FIELD from '@salesforce/schema/Case.ContactId';
import { createRecord } from 'lightning/uiRecordApi';


export default class QuickCase extends LightningElement {
    @api objectApiName;//either contact OR Account 
    @api recordId;// record Id 


    subject;
    description;
    status;
    origin; 
    priority;
    statusOptions;
    priorityOptions;
    originOptions;

    @wire(getObjectInfo, {
        objectApiName: CASE_OBJECT
    })
    caseObjectInfo;

    @wire(getPicklistValues, {
        recordTypeId: '$caseObjectInfo.data.defaultRecordTypeId',
        fieldApiName: STATUS_FIELD
    })
    statusPicklistResponse ({ data, error }) { 
        if (data)
        { 
            const statusResponse = data.values;
            this.statusOptions=statusResponse.map(currItem => { 
                return {
                    label: currItem.label,
                    value:currItem.value,
                }
            })
        }
    }

    @wire(getPicklistValues, {
        recordTypeId: '$caseObjectInfo.data.defaultRecordTypeId',
        fieldApiName: ORIGIN_FIELD
    })
    originPicklistResponse ({ data, error }) { 
        if (data)
        { 
            const originResponse = data.values;
            this.originOptions=originResponse.map(currItem => { 
                return {
                    label: currItem.label,
                    value:currItem.value,
                }
            })
        }
    }

    @wire(getPicklistValues, {
        recordTypeId: '$caseObjectInfo.data.defaultRecordTypeId',
        fieldApiName: PRIORITY_FIELD
    })
    priorityPicklistResponse ({ data, error }) { 
        if (data)
        { 
            const priorityResponse = data.values;
            this.priorityOptions=priorityResponse.map(currItem => { 
                return {
                    label: currItem.label,
                    value:currItem.value,
                }
            })
        }
    }
    
    // handlers 
    handleChange (event) { 
        let eventName = event.target.name;
        switch (eventName)
        {
            case 'CaseStatus':
                this.status = event.target.value;
                break;
            case 'CaseOrigin':
                this.origin = event.target.value;
                break;
            case 'CasePriority':
                this.priority = event.target.value;
                break;
        }
    }
    handleDescriptionChange (event) { 
        this.description = event.target.value;
        console.log('description chaged..',this.description)
    }
    handleSubjectChange (event) { 
        this.subject = event.target.value;
        console.log('subject chaged..',this.subject)
    }

    handleCreateCase (event) { 
        event.preventDefault();
        // perform some validation logic 
        const fields = {};
        fields[SUBJECT_FIELD.fieldApiName] = this.subject;
        fields[DESCRIPTION_FIELD.fieldApiName] = this.description;
        fields[STATUS_FIELD.fieldApiName] = this.status;
        fields[ORIGIN_FIELD.fieldApiName] = this.origin;
        fields[PRIORITY_FIELD.fieldApiName] = this.priority;
        //check the parent object 
        if (this.objectApiName == 'Account')
        {
            fields[ACCOUNT_ID_FIELD.fieldApiName] = this.recordId;
        }
        else if (this.objectApiName == 'Contact')
        { 
            fields[CONTACT_ID_FIELD.fieldApiName] = this.recordId;
        }

        const recordInput = {
            apiName: CASE_OBJECT.objectApiName,
            fields:fields,
        }
        console.log('subject ...',this.subject)
        //create the object 
        createRecord(recordInput)
            .then(res => { 
                            const successEvent=new ShowToastEvent({
                            title: 'Case created',
                            message:'Case is created Successfully!',
                            variant:'success'
                        });
                        this.dispatchEvent(successEvent);
            })
            .catch(err => { 
                const errorEvent=new ShowToastEvent({
                            title: 'Something Wrong',
                            message:'Something went wrong!',
                            variant:'error'
                        });
                        this.dispatchEvent(errorEvent);
            }).finally(() => {
                this.subject = undefined;
                this.description = undefined;
                this.status = undefined;
                this.origin = undefined;
                this.priority = undefined;
            })

    }

}