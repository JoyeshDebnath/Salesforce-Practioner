import { LightningElement ,api,wire } from 'lwc';
import { subscribe,MessageContext } from 'lightning/messageService';
import COUNTING_UPDATED_CHANNEL  from '@salesforce/messageChannel/Counting_update__c';

export default class SubComponent extends LightningElement {
    countValue = 0;
    subscrption = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback () { 
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel () { 
        this.subscription = subscribe(
            this.messageContext,
            COUNTING_UPDATED_CHANNEL,
            (message) => this.handleMessage(message)
        );
    }

    handleMessage (message) { 
        // alert('Message: ' + JSON.stringify(message));
        if (message.operator === 'add')
        {
            this.countValue += message.constant
        }
        else if (message.operator === 'subtract')
        {
            this.countValue -= message.constant
        }
        else if (message.operator === 'multiply')
        { 
            this.countValue*=message.constant
        }

    }
}