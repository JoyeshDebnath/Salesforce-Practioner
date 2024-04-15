import { LightningElement } from 'lwc';

export default class CustomLightningCard extends LightningElement {

    handleSlotFooterChange(){
        const footerEl = this.template.querySelector('footer');
        if(footerEl){
            //if footer available
            footerEl.classList.remove('slds-hide')
        }
        
    }
}