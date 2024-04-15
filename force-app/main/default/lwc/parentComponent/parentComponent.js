import { LightningElement,api } from 'lwc';

export default class ParentComponent extends LightningElement {
    message
    cardHeading;

    carouselData=[
        {
            src:"https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg",
            header:"First Card",
            description:"First card description.",
            alternativeText:"First card accessible description.",
            href:"javascript:void(0);"
        },
        {
            src:"https://www.lightningdesignsystem.com/assets/images/carousel/carousel-02.jpg",
            header:"Second Card",
            description:"Second card description.",
            alternativeText:"Second card accessible description.",
            href:"javascript:void(0);"
        }
    ]
    percentage=10;
    percentHandler(event){
        event.preventDefault();
        this.percentage=event.target.value;
    }

    handleClick(event){
        event.preventDefault();
        //get the reference of the component 
        const sliderComponent = this.template.querySelector('c-slider-compo');
        sliderComponent.resetSlider();// cal the metghod of the child 
    }
}