# Using GDB to Debug Assembly

To launch `gdb` type `gdb exe-name`. To quit, type `quit`.

Set intel flavor: `set disassembly-flavor intel`. (You can add this to a
`.gdbinit` file in the user's home directory.)

`disassemble <label>` will display disassembled source for the label.

`x/s <memory addr>` will display the string contents of the memory location.
(Stands for examine string.)

`x/c <memory addr>` will display the char/byte at the memory address.

`x/<num>c <memory addr>` will display <num> chars from the memory location. For
example: `x/12c 0x0402B`. Or show them in decimal with `x/d`.
