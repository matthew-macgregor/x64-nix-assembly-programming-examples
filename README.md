# x64 Assembly Language Examples (Unix/Linux)

The following examples were created while working through the book *Beginning
x64 Assembly Programming: From Novice to AVX Professional* by Jo Van Hoey. Most
of the examples were modified from the original, or were only inspired by those
in the book. Others may be unrelated to the book as I tried out other things in
order to understand concepts.

All of the examples here, regardless of modifications from the examples in the
book, were hand typed in order to get familiar with the code. No copy-pasta!

Additional or modified code is Copyright &copy; 2021 Matthew MacGregor, and
licensed under the same Freeware License as the original. See
[License](LICENSE.txt) for details.

Specific additions or modifications:
- Makefiles: the build system is original to this repository, allowing 
  `make all` and `make run` to build/run all examples.
- Helpers: `mksrc` script creates new example directories. `init.source` for
  initializing environment variables and aliases.
- Explanatory inline comments for clarity of sections of code I found
  confusing.

Original example code is here:

https://github.com/Apress/beginning-x64-assembly-programming.

## Building the Code

This project is intended to be used from a Unix-like system as the assembly
code used throughout assumes POSIX system calls. It has been tested from
several Linux OS distributions (Ubuntu 20.04, Fedora 35) and Windows Subsystem
for Linux.

Created with: `NASM version 2.14.02`, `NASM version 2.15.05`, but other versions may work.

- To build all: `make all`
- To build and run all: `make run`
- To run a single target: `make run-{target_name}`
