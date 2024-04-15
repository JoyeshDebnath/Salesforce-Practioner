import { LightningElement,track } from 'lwc';

export default class TrackDemo extends LightningElement {

    fullName='Joyesh Debnath';
    users=["John","Shawn","Mendis"];

    title='LWC';

    changeHandler(event){
        event.preventDefault();
        this.title=event.target.value;
    }

   
    address={
        city:'Tokyo',
        country:"Japan",
        street:"177/9 Yokohoma"
    }

    trackHandler(event){
        event.preventDefault();
        this.address={...this.address,"city":event.target.value};
   
    }

    get firstUser(){
        return this.users[0];
    }


}