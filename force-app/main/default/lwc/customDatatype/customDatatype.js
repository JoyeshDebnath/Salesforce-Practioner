import  LightningDatatable  from 'lightning/datatable';
import customNameTemplate from './CustomName.html';
import customImageTemplate from './CustomImage.html';
import customRankTemplate from './CustomRank.html';

export default class CustomDatatype extends LightningDatatable {
    static customTypes = {
        customName: {
            template: customNameTemplate,
            standardCellLayout: true,
            typeAttributes:['contactName']
        },
        customRank: {
            template: customRankTemplate,
            standardCellLayout: false,
            typeAttributes:['rankIcon']
        },
        customPicture:{ 
            template: customImageTemplate,
            standardCellLayout: true,
            typeAttributes:['pictureUrl']
        }
    }
}