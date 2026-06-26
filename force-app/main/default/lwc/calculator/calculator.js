import { LightningElement } from 'lwc';
export default class Calculator extends LightningElement {
    input1;
    input2;
    Result;
   
   onChangeHandle(event){
        const inputName = event.target.name;
        const inputValue = event.target.value;

        if(inputName === "input1"){
              this.input1 = inputValue;
        }
        else if(inputName === "input2"){
              this.input2 = inputValue;
        }
   }

   addition(){
      this.Result = Number(this.input1) + Number(this.input2);
   }

   subtraction(){
       this.Result = Number(this.input1) - Number(this.input2);
   }

   divison(){
       if(this.input2 == 0){
           alert("Input 2 must be greater than zero")
       }else{
           this.Result = Number(this.input1) / Number(this.input2);
       }
   }

   multiplication(){
      this.Result = Number(this.input1) * Number(this.input2);
   }
}1