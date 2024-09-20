# EEdelsteinModule1 
## EN.605.204.83.FA24
## Module 5 - Assignment  


### Question 1: Tempature Converter:

2 programs implemented: Fahrenheit2Celsius and Celsius2Fahrenheit. Each converts from one tempature to another:

```shell
gcc Fahrenheit2Celsius.s -o Fahrenheit2Celsius && ./Fahrenheit2Celsius
gcc Celsius2Fahrenheit.s -o Celsius2Fahrenheit && ./Celsius2Fahrenheit
```

### Question 2: 2s Compliment Negate:
This program neagtes an interger using 2s compliment operations
```shell
gcc Negate.s -o Negate && ./Negate
```

### Question 3: Size Counter:
2 programs implemented. The first, Inches.s, converts feet and inches to total feet. The second, FeetAndInches.s converts total inches to feet and inches.

```shell
gcc Inches.s -o Inches && ./Inches
gcc FeetAndInches -o FeetAndInches && ./FeetAndInches
```

### Question 4: Multiply By Ten:
This program , TimesTen.s, multiplies a number by ten using shift and add operations. Multipying by ten is equivelent to (x * 2^3) + (x * 2^1). The two multiplications by a power of 2 can be implemented using a LeftShift by 3 and a Left Shift by 1.
```shell
gcc TimesTen.s -o TimesTen && ./TimesTen
```

### Question 5: [EC] Swap
This program, Swap.s, uses Exclusive Or operations (EOR or XOR) to swap 2 variable without a temp variable.
```shell
gcc Swap.s -o Swap && ./Swap
```

