import { LightningElement,api } from 'lwc';

export default class P2cSliderCompo extends LightningElement {
    sliderLabel = "Slider label"
    sliderVal = 50;

    onSliderChangeHandler (event) { 
        this.sliderVal=event.target.value
    }

    @api resetSlider(){
        this.sliderVal = 0;
    }
}