import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    greeting = 'John Doe';

    changeHandler(event) {
      this.greeting = event.target.value;
    }

}