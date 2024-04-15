import { LightningElement } from 'lwc';

export default class ForEachDemo extends LightningElement {
    carList=['Ford','Suzuki','Maruti','Toyota','Marcedes','Audi'];
    persons=[
        {
            id:123,
            name:"Lisa Suzuki",
            nation:"Japan"
        },
        {
            id:432,
            name:"Joyesh Debnath",
            nation:"India"
        },
        {
            id:782,
            name:"Srinjoy Chanda",
            nation:"Nepal"
        }
    ]

}