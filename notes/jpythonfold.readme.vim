This script allows automatically folding of Python code.
It completely rewritten from Jorrit Wiersma's script (vimscript #515; other competitors are vimscript#781 and vimscript#2002).
The folding and fold text are completely rewritten: the algorithm systematically set up, so it behaves as accurate as possible (at the cost of some speed).
Main feature of this script is that it folds empty space, saving lots of screen space (although you can turn it off, see below).
Classes and defs are folded, of course.
Indent zero comments separating classes and defs are not folded, so you see the global divisions in your code.
Global code is folded in blocks (separated by comments).

There are three options. To use them, check the script:
- Keep empty lines out of a fold (giving more readable classes with folded functions, but using more screen space).
- Ignore non-python files.
- Allow for multiline class definitions (at the cost of folding comments starting with the word "class") or stricter def checking (missing multiline defs).

Known bug:
- multiline strings that look like code are handled as such (basically unfixable, actually)

Example:
------------------------
#unfolded comment
def foo:
#folded comment
    #also folded
    bar = 5

#unfolded, but the empty line above this one is folded with the function
#code below will be folded
a = 5
b = 6
