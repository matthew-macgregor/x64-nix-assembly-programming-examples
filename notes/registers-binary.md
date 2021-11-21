# Notes

## Binary Data

**Signed Integers** have the leftmost bit set to 1 if negative.

Two's complement:
1. Find the binary version of the absolute value of the number.
2. Take the complement. (Reverse all 1's to 0's and 0's to 1's).
3. Add 1.

**Example**

decimal is   12
binary  is   0000 1100
hex     is   0C

decimal is   -12

1. Find absolute value:

0000 1100

2. Take complement:

1111 0011

3. Add one:

1111 0100

Test:

    1111 0100
+   0000 1100
    ---------
    0000 0000

## Registers

x64 has 16 general-purpose 64-bit registers capable of being
referenced as 8,16,32 or 64 bits.

`rax`,`rbx`,`rcx` and `rdx` have a low and high 8-bit register.
For example:

`rax` 64-bit, `eax` 32-bit, `ax` 16-bit, `al` lo 8-bit, `ah` hi 8-bit

Meanwhile `rbp` and `rsp` are used by the processor, so require
special handling.

`rip` is the instruction pointer.

`rflags` is the flag register, which stores bitfields for the
following values:

Carry 		CF, Bit 0  -- Last inst had carry
Parity		PF, Bit 2  -- Last byte has even number of 1's
Adjust		AF, Bit 4  -- BCD operations
Zero		ZF, Bit 6  -- Last inst was zero
Sign		SF, Bit 8  -- Last inst caused MSB to be 1
Direction	DF, Bit 10 -- Incr or Decr of string operations
Overflow	OF, Bit 11 -- Previous inst caused overflow

`MXCSR` register is used in `SIMD` instructions. `SIMD` stands for
"single instruction, multiple data".

Two registers are used for floating-point calculations, called
`xmm` and `ymm`.

