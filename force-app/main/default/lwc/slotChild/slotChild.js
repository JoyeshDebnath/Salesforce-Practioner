import { LightningElement } from 'lwc';

export default class SlotChild extends LightningElement {
    
    
    handleSlotChange (event) { 
        const footerEle = this.template.querySelector('.slds-card__footer');
        if(footerEle)
                footerEle.classList.remove('slds_hide');
    }
}