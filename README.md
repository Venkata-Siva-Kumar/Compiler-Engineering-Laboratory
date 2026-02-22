📘 Compiler Engineering Laboratory

This repository contains all the experiments implemented as part of the Compiler Engineering Laboratory course.

The programs are developed using:

C Programming Language

Lex (Flex) – Lexical Analyzer Generator

YACC (Bison) – Parser Generator

GCC Compiler

Linux / WSL Environment

📂 Repository Structure
Compiler-Engineering-Laboratory/
│
├── EXP-1   → Lexical Analyzer Programs
├── EXP-2   → Conditional Statements Parser (IF, SWITCH)
├── EXP-3   → Looping Statements Parser (FOR, WHILE, DO-WHILE)
└── README.md

Each experiment folder contains:

.l files (Lex programs)
.y files (YACC programs)

Sample test cases
Output results


⚙️ Compilation and Execution

🔹 Lex Program
lex filename.l
cc lex.yy.c
./a.out

🔹 Lex + YACC Program
lex filename.l
yacc -d filename.y
cc lex.yy.c y.tab.c
./a.out



📚 Concepts Covered

Regular Expressions
Tokenization
Context Free Grammar (CFG)
Backus–Naur Form (BNF)
Syntax Analysis
Shift-Reduce Parsing
Nested Construct Parsing
Error Handling in Parser Design



🛠 Tools & Technologies

C Language
Lex / Flex
YACC / Bison
GCC
Linux (WSL)


👨‍💻 Author

Mariyala Venkata Siva Kumar
B.Tech – Computer Science and Engineering
Compiler Engineering Laboratory
