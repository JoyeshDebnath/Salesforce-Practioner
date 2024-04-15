import { LightningElement } from 'lwc';

export default class ParentToChildDemo1 extends LightningElement {
    carouselData = [
        {
            src: "https://i0.wp.com/animegalaxyofficial.com/wp-content/uploads/2021/04/Tokyo-revengers-1.jpg?resize=750%2C509&ssl=1",
            header: "First Card",
            description: "First card description.",
            alternativeText: "First card accessible description.",
            href: "javascript:void(0);"
        },
        {
            src: "https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Doraemon_characters_%282005%29.png/220px-Doraemon_characters_%282005%29.png",
            header: "Second Card",
            description: "Second card description.",
            alternativeText: "Second card accessible description.",
            href: "javascript:void(0);"
        },
        {
            src: "https://staticg.sportskeeda.com/editor/2023/05/e9a78-16854664390983-1920.jpg?w=840",
            header: "Third Card",
            description: "Third card description.",
            alternativeText: "Third card accessible description.",
            href: "javascript:void(0);"
        }
    ]
    progressVal = 50;

    changeHandler (event) {
        this.progressVal = event.target.value;
    }

    handleClick (event) { 
        const childComp = this.template.querySelector('c-p2c-slider-compo');
        childComp.resetSlider();
    }
}