<div align="center">
📘 Compiler Engineering Laboratory
🧠 Lex • YACC • C Programming • Compiler Design
</div>
📖 About This Repository

This repository contains all the experiments implemented as part of the Compiler Engineering Laboratory course.

The objective of this lab is to understand and implement the core phases of a compiler, including:

Lexical Analysis
Syntax Analysis
Grammar Design
Parser Construction

______________________________________________________
🖥 Technologies Used

C Programming Language
Lex (Flex) – Lexical Analyzer Generator
YACC (Bison) – Parser Generator
GCC Compiler

Linux / WSL Environment
______________________________________________________
📂 Repository Structure

Compiler-Engineering-Laboratory/
│
├── EXP-1   → Lexical Analyzer Programs
├── EXP-2   → Conditional Statements Parser (IF, SWITCH)
├── EXP-3   → Looping Statements Parser (FOR, WHILE, DO-WHILE)
└── README.md

______________________________________________________
📁 Each Experiment Folder Contains

.l files (Lex programs)
.y files (YACC programs)
Sample test cases
Output screenshots

______________________________________________________
⚙️ Compilation & Execution
🔹 For Lex Programs
lex filename.l
cc lex.yy.c
./a.out

🔹 For Lex + YACC Programs
lex filename.l
yacc -d filename.y
cc lex.yy.c y.tab.c
./a.out

______________________________________________________
📚 Concepts Covered

Regular Expressions
Tokenization
Context Free Grammar (CFG)
Backus–Naur Form (BNF)
Shift-Reduce Parsing
Nested Constructs
Error Detection & Handling
Syntax Validation of C Constructs

______________________________________________________

<div align="center">
👨‍💻 Author

Mariyala Venkata Siva Kumar
B.Tech – Computer Science and Engineering
Compiler Engineering Laboratory

</div>
