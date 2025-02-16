function solve(numbers : number[]): void{

    numbers.sort((a,b) => b-a)
    let firstNum : number = 0 
    let secondNum : number = 0
    
    for (let i = 0; i < numbers.length; i += 2) {
        let a : String = String(numbers[i])
        let b : String = numbers[i + 1] !== undefined ? String(numbers[i + 1]) : "";

        if(Number(String(firstNum)+a) * Number(String(secondNum)+b) >= Number(String(firstNum)+b) * Number(String(secondNum)+a)){
            firstNum = Number(String(firstNum)+a)
            secondNum = Number(String(secondNum)+b)
        }else{
            firstNum = Number(String(firstNum)+b)
            secondNum = Number(String(secondNum)+a)
        }
    }
    console.log("result: "+firstNum + ", " +secondNum)
    
} 

solve([1,3,5,7,9]) // result: 93, 751

