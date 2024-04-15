import { LightningElement,track } from 'lwc';

export default class DataBinding extends LightningElement {
    @track title="Software Engineer";
    fullName = 'Lisa Suzuki';
    
    changeHandler(event) {
      event.preventDefault();
      this.title=event.target.value;       
    }
}