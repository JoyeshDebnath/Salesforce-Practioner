import { LightningElement } from 'lwc';

export default class BmiCalculator extends LightningElement {
    height = 0;
    weight = 0;
    bmiValue = 0;
    verdict = '';

    handleInput (e) {
        const { name, value } = e.target;
        if (name === 'weight')
        {
            this.weight = value;
        }
        if (name === 'height')
        {
            this.height = value;

        }
    }

    handleSubmit (e) {
        e.preventDefault();
        console.log('Weight   :' + this.weight + '  Height  :' + this.height);
        this.calculate();
    }

    calculate () {
        let ht = Number(this.height) / 100;
        let bmi = Number(this.weight) / (ht * ht);
        this.bmiValue = Number(bmi.toFixed(2));
        this.verdict = this.determineVerdict(this.bmiValue);

    }

    determineVerdict (bmiVal) { 
        if (bmiVal < 18.5)
        {
            return "UnderWeight!"
        }
        else if (bmiVal > 18.5 && bmiVal <= 24.9)
        {
            return "Healthy !"
        }
        else if (bmiVal >= 25.0 && bmiVal <= 29.9)
        {
            return "OverWeight!"
        }
        else
        { 
            return "Obese!"
        }
    }

    reset () { 
        this.height = 0;
        this.weight = 0;
        this.bmiValue = 0;
        this.verdict = '';
    }
}