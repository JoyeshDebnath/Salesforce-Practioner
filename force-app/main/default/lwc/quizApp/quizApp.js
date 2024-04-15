import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {
    
    selected={};
    correctAns=0;
    isSubmitted=false;

    myQuestions=[
        {
            id:'Question1',
            Question:'Which of the following is not a template loop',
            Answers:{
                a:"for:each",
                b:"iterator",
                c:"map loop"
            },
            correctAnswer:"c"
        },
        {
            id:'Question2',
            Question:'Which of the following is Invalid in Component folder',
            Answers:{
                a:".svg",
                b:".apex",
                c:".js"
            },
            correctAnswer:"b"
        },
        {
            id:'Question3',
            Question:'Which of the following is not a Directive',
            Answers:{
                a:"@track",
                b:"iterator",
                c:"map loop"
            },
            correctAnswer:"a"
        }
    ]

    get allNotSelected(){
           return !(Object.keys(this.selected).length===this.myQuestions.length)
    }

    changeHandler(event){
        event.preventDefault();
        // alert(event.target.value,event.target.name)
        const {name,value}=event.target;
        this.selected={...this.selected,[name]:value}
    }

    resetHandler(event){
        event.preventDefault();
        this.correctAns=0;
        this.isSubmitted=false;
    }

    submitHandler(event){
        event.preventDefault();
        //check for correct answers 
        let correct=this.myQuestions.filter((question)=>{
            return (this.selected[question.id]===question.correctAnswer);
        })

     this.correctAns=correct.length
     alert(this.correctAns);
     this.isSubmitted=true;
    }

    get isScoredFull(){
        return `slds-text-heading_large ${this.myQuestions.length === this.correctAns ? 'slds-text-color_success' : 'slds-text-color_error'}`
    }


}