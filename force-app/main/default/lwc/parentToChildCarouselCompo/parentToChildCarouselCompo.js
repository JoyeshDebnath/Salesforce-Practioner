import { LightningElement,api } from 'lwc';

export default class ParentToChildCarouselCompo extends LightningElement {

    @api cardHeading;
    @api carouselData;
}