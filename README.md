### Computer system architecture :computer: 
# Reverse Polish notation 
**Assignment**: 
1. A hex string is given as input. It is required to display the corresponding assembly instruction to be executed in the standard output.
_Example:_

> _Input_
``` assembly
A78801C00A7890EC04
```
> _Output_
``` assembly
x 1 let x -14 div
```
2. An instruction in the assembly language of the specified arithmetic processor is given as input. It is required to display the evaluation of the instruction in the standard output. (***Note***: There are no variables in the instruction, only integers and operations. All operations are guaranteed to be unsigned.)

_Example:_

> _Input_
``` assembly
2 10 mul 5 div 7 6 sub add
```

> _Output_
``` assembly
5
```

3. An instruction in the assembly language of the specified arithmetic processor is given as input. It is required to display the evaluation of the instruction in the standard output. (Note: Unlike the instruction in exercise 2, this instruction contains variables introduced by let. All operations are guaranteed to be unsigned.)

_Example:_

> _Input_
``` assembly
x 1 let 2 x add y 3 let x y add mul
```

> _Output_
``` assembly
12
```

4. A matrix is given as input and is requested to be displayed in the standard output the matrix after the operations have been applied. (***Note***: It is guaranteed that all operations will be signed).

***We can use the following operations:***
- add: we add all the elements in the matrix with the value of the operand
- sub: we subtract from all the elements in the matrix with the value of the operand
- mul: we multiply all the elements in the matrix by the value of the operand
- div: we divide all the elements in the matrix by the value of the operand
- rot90d: we rotate the matrix 90 degrees to the right

A matrix is given as input. It is required to display the matrix after the specified operations have been applied in the standard output. (***Note***: All operations are guaranteed to be signed.)

***The following operations can be used***:

- add: all elements in the matrix are added with the value of the operand
- sub: all elements in the matrix are subtracted by the value of the operand
- mul: all elements in the matrix are multiplied by the value of the operand
- div: all elements in the matrix are divided by the value of the operand
- rot90d: The matrix is rotated 90 degrees to the right.

_Example:_

1. 
> _Input_
``` assembly
x 2 3 1 2 3 4 5 6 let x -2 add
```

> _Output_
``` assembly
2 3 -1 0 1 2 3 4
```

2. 
> _Input_
``` assembly
x 2 3 -1 0 1 2 3 4 let x rot90d
```

> _Output_
``` assembly
3 2 2 -1 3 0 4 1
```
