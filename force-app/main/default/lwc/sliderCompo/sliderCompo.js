import { LightningElement,api } from 'lwc';

export default class SliderCompo extends LightningElement {
                val=20;

                changeValHandler(event){
                    event.preventDefault();
                    this.val=event.target.value;
                }
//making the methods public 
                @api resetSlider(){
                    this.val=50;
                }
}