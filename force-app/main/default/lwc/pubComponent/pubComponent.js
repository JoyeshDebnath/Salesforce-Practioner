import { LightningElement,wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/Counting_update__c';

export default class PubComponent extends LightningElement {

    @wire(MessageContext)
    messageContext;
    handleAdd () { 
        const payload = {
            operator: 'add',
            constant:1
        }
        
        publish(this.messageContext, COUNTING_UPDATED_CHANNEL, payload);
    }

    handleSubtract () {
        const payload = {
            operator: 'subtract',
            constant:1
        }

        publish(this.messageContext,COUNTING_UPDATED_CHANNEL,payload)
    }

    handleMultiply () {
        const payload = {
            operator: 'multiply',
            constant:2
        }

        publish(this.messageContext, COUNTING_UPDATED_CHANNEL, payload);
    }
}