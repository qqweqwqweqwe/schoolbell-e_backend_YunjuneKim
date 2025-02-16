function solve(numbers) {
    numbers.sort(function (a, b) { return b - a; });
    var firstNum = 0;
    var secondNum = 0;
    for (var i = 0; i < numbers.length; i += 2) {
        var a = String(numbers[i]);
        var b = numbers[i + 1] !== undefined ? String(numbers[i + 1]) : "";
        if (Number(String(firstNum) + a) * Number(String(secondNum) + b) >= Number(String(firstNum) + b) * Number(String(secondNum) + a)) {
            firstNum = Number(String(firstNum) + a);
            secondNum = Number(String(secondNum) + b);
        }
        else {
            firstNum = Number(String(firstNum) + b);
            secondNum = Number(String(secondNum) + a);
        }
    }
    console.log("result: " + firstNum + ", " + secondNum);
}
solve([1, 3, 5, 7, 9]);
