import { LightningElement,api } from 'lwc';

export default class ParentToChildAlertCompo extends LightningElement {
    @api message;
    @api cardHeading;
}