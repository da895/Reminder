


# Structures, unions, enumerations, and bitfields


<!-- vim-markdown-toc GFM -->

* [Unions](#unions)
* [Enumerations](#enumerations)
        * [Handling values that are out of range](#handling-values-that-are-out-of-range)
* [Structures](#structures)
* [Packed structures](#packed-structures)
* [Bitfields](#bitfields)
* [Unions](#unions-1)
* [Enumerations](#enumerations-1)
        * [Handling values that are out of range](#handling-values-that-are-out-of-range-1)
* [Structures](#structures-1)
* [Packed structures](#packed-structures-1)
* [Bitfields](#bitfields-1)
* [Bitfields in packed structures](#bitfields-in-packed-structures)
* [Bitfields in packed structures](#bitfields-in-packed-structures-1)

<!-- vim-markdown-toc -->


This topic describes the implementation of the structured data types union, enum, and struct. It also discusses structure padding and bitfield implementation.

See [_Anonymous classes, structures and unions_](https://developer.arm.com/documentation/dui0491/i/Language-Extensions/Anonymous-classes--structures-and-unions?lang=en "Anonymous classes, structures and unions") for more information.

## Unions

When a member of a union is accessed using a member of a different type, the resulting value can be predicted from the representation of the original type. No error is given.

## Enumerations

An object of type enum is implemented in the smallest integral type that contains the range of the enum.

In C mode, and in C++ mode without `--enum_is_int`, if an enum contains only positive enumerator values, the storage type of the enum is the first _unsigned_ type from the following list, according to the range of the enumerators in the enum. In other modes, and in cases where an enum contains any negative enumerator values, the storage type of the enum is the first of the following, according to the range of the enumerators in the enum:

- unsigned char if not using `--enum_is_int`
  
- signed char if not using `--enum_is_int`
  
- unsigned short if not using `--enum_is_int`
  
- signed short if not using `--enum_is_int`
  
- signed int
  
- unsigned int except C with `--strict`
  
- signed long long except C with `--strict`
  
- unsigned long long except C with `--strict`.
  

> ### Note
> 
> - In RVCT 4.0, the storage type of the enum being the first unsigned type from the list is only applicable in GNU (`--gnu`) mode.
>     
> - In ARM Compiler 4.1 and later, the storage type of the enum being the first unsigned type from the list applies irrespective of mode.
>     

Implementing enum in this way can reduce data size. The command-line option `--enum_is_int` forces the underlying type of enum to at least as wide as int.

See the description of C language mappings in the _Procedure Call Standard for the ARM Architecture_ specification for more information.

> ### Note
> 
> Care must be taken when mixing translation units that have been compiled with and without the `--enum_is_int` option, and that share interfaces or data structures.

#### Handling values that are out of range

In strict C, enumerator values must be representable as ints, for example, they must be in the range -2147483648 to +2147483647, inclusive. In some earlier releases of RVCT out-of-range values were cast to int without a warning (unless you specified the `--strict` option).

In RVCT v2.2 and later, a Warning is issued for out-of-range enumerator values:

```

#66: enumeration value is out of "int" range

```

Such values are treated the same way as in C++, that is, they are treated as unsigned int, long long, or unsigned long long.

To ensure that out-of-range Warnings are reported, use the following command to change them into Errors:

```

armcc --diag_error=66 ...

```

## Structures

The following points apply to:

- all C structures
  
- all C++ structures and classes not using virtual functions or base classes.
  

Structure alignment

The alignment of a nonpacked structure is the maximum alignment required by any of its fields.

Field alignment

Structures are arranged with the first-named component at the lowest address. Fields are aligned as follows:

- A field with a char type is aligned to the next available byte.
  
- A field with a short type is aligned to the next even-addressed byte.
  
- In RVCT v2.0 and above, double and long long data types are eight-byte aligned. This enables efficient use of the `LDRD` and `STRD` instructions in ARMv5TE and above.
  
- Bitfield alignment depends on how the bitfield is declared. See [_Bitfields in packed structures_](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babcgedf "Bitfields in packed structures") for more information.
  
- All other types are aligned on word boundaries.
  

Structures can contain padding to ensure that fields are correctly aligned and that the structure itself is correctly aligned. [Figure 3](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babcbhch "Figure 3. Conventional nonpacked structure example") shows an example of a conventional, nonpacked structure. Bytes 1, 2, and 3 are padded to ensure correct field alignment. Bytes 11 and 12 are padded to ensure correct structure alignment. The `sizeof()` function returns the size of the structure including padding.

**Figure 3. Conventional nonpacked structure example**

[![Figure 3. Conventional nonpacked structure example](blob:https://developer.arm.com/ac4e0d8a-b721-4db6-8c79-9476a77b6f28)](https://documentation-service.arm.com/static/5f90173ef86e16515cdc13c1?token=)

  

The compiler pads structures in one of the following ways, according to how the structure is defined:

- Structures that are defined as static or extern are padded with zeros.
  
- Structures on the stack or heap, such as those defined with `malloc()` or auto, are padded with whatever is previously stored in those memory locations. You cannot use `memcmp()` to compare padded structures defined in this way (see [Figure 3](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babcbhch "Figure 3. Conventional nonpacked structure example")).
  

Use the `--remarks` option to view the messages that are generated when the compiler inserts padding in a struct.

Structures with empty initializers are permitted in C++:

```

struct

{

    int x;

} X = { };

```

However, if you are compiling C, or compiling C++ with the `--cpp` and`--c90` options, an error is generated.

## Packed structures

A packed structure is one where the alignment of the structure, and of the fields within it, is always 1.

You can pack specific structures with the `__packed` qualifier. Alternatively, you can use `#pragma pack(_n_)` to make sure that any structures with unaligned data are packed. There is no command-line option to change the default packing of structures.

## Bitfields

In nonpacked structures, the ARM compiler allocates bitfields in _containers_. A container is a correctly aligned object of a declared type.

Bitfields are allocated so that the first field specified occupies the lowest-addressed bits of the word, depending on configuration:

Little-endian

Lowest addressed means least significant.

Big-endian

Lowest addressed means most significant.

A bitfield container can be any of the integral types.

> ### Note
> 
> In strict 1990 ISO Standard C, the only types permitted for a bit field are int, signed int, and unsigned int. For non-int bitfields, the compiler displays an error.

A plain bitfield, declared without either signed or unsigned qualifiers, is treated as unsigned. For example, `int x:10` allocates an unsigned integer of 10 bits.

A bitfield is allocated to the first container of the correct type that has a sufficient number of unallocated bits, for example:

```

struct X

{

    int x:10;

    int y:20;

};

```

The first declaration creates an integer container and allocates 10 bits to `x`. At the second declaration, the compiler finds the existing integer container with a sufficient number of unallocated bits, and allocates `y` in the same container as `x`.

A bitfield is wholly contained within its container. A bitfield that does not fit in a container is placed in the next container of the same type. For example, the declaration of `z` overflows the container if an additional bitfield is declared for the structure:

```

struct X

{

    int x:10;

    int y:20;

    int z:5;

};

```

The compiler pads the remaining two bits for the first container and assigns a new integer container for `z`.

Bitfield containers can _overlap_ each other, for example:

```

struct X

{

    int x:10;

    char y:2;

};

```

The first declaration creates an integer container and allocates 10 bits to `x`. These 10 bits occupy the first byte and two bits of the second byte of the integer container. At the second declaration, the compiler checks for a container of type char. There is no suitable container, so the compiler allocates a new correctly aligned char container.

Because the natural alignment of char is 1, the compiler searches for the first byte that contains a sufficient number of unallocated bits to completely contain the bitfield. In the example structure, the second byte of the int container has two bits allocated to `x`, and six bits unallocated. The compiler allocates a char container starting at the second byte of the previous int container, skips the first two bits that are allocated to `x`, and allocates two bits to `y`.

If `y` is declared `char y:8`, the compiler pads the second byte and allocates a new char container to the third byte, because the bitfield cannot overflow its container. [Figure 4](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babbfgad "Figure 4. Bitfield allocation 1") shows the bitfield allocation for the following example structure:

```

struct X

{

    int x:10;

    char y:8;

};

```

**Figure 4. Bitfield allocation 1**

![64756c0b23c4e0c2a34a92a62a30a9e2_MD5](https://github.com/user-attachments/assets/95805949-a3a8-4185-9335-038170103541)




> ### Note
> 
> The same basic rules apply to bitfield declarations with different container types. For example, adding an int bitfield to the example structure gives:

> ```
> 
> struct X
> 
> {
> 
>     int x:10;
> 
>     char y:8;
> 
>     int z:5;
> 
> }
> 
> ```

The compiler allocates an int container starting at the same location as the `int x:10` container and allocates a byte-aligned char and 5-bit bitfield, see [Figure 5](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babfdbfi "Figure 5. Bitfield allocation 2").

**Figure 5. Bitfield allocation 2**

![c7bd13fb3da7285fae54080d1437776f_MD5](https://github.com/user-attachments/assets/40a75cce-a3b3-4b4a-b9b7-7e28b4210965)

  

You can explicitly pad a bitfield container by declaring an unnamed bitfield of siz## Structures, unions, enumerations, and bitfields

This topic describes the implementation of the structured data types union, enum, and struct. It also discusses structure padding and bitfield implementation.

See [_Anonymous classes, structures and unions_](https://developer.arm.com/documentation/dui0491/i/Language-Extensions/Anonymous-classes--structures-and-unions?lang=en "Anonymous classes, structures and unions") for more information.

## Unions

When a member of a union is accessed using a member of a different type, the resulting value can be predicted from the representation of the original type. No error is given.

## Enumerations

An object of type enum is implemented in the smallest integral type that contains the range of the enum.

In C mode, and in C++ mode without `--enum_is_int`, if an enum contains only positive enumerator values, the storage type of the enum is the first _unsigned_ type from the following list, according to the range of the enumerators in the enum. In other modes, and in cases where an enum contains any negative enumerator values, the storage type of the enum is the first of the following, according to the range of the enumerators in the enum:

- unsigned char if not using `--enum_is_int`
  
- signed char if not using `--enum_is_int`
  
- unsigned short if not using `--enum_is_int`
  
- signed short if not using `--enum_is_int`
  
- signed int
  
- unsigned int except C with `--strict`
  
- signed long long except C with `--strict`
  
- unsigned long long except C with `--strict`.
  

> ### Note
> 
> - In RVCT 4.0, the storage type of the enum being the first unsigned type from the list is only applicable in GNU (`--gnu`) mode.
>     
> - In ARM Compiler 4.1 and later, the storage type of the enum being the first unsigned type from the list applies irrespective of mode.
>     

Implementing enum in this way can reduce data size. The command-line option `--enum_is_int` forces the underlying type of enum to at least as wide as int.

See the description of C language mappings in the _Procedure Call Standard for the ARM Architecture_ specification for more information.

> ### Note
> 
> Care must be taken when mixing translation units that have been compiled with and without the `--enum_is_int` option, and that share interfaces or data structures.

#### Handling values that are out of range

In strict C, enumerator values must be representable as ints, for example, they must be in the range -2147483648 to +2147483647, inclusive. In some earlier releases of RVCT out-of-range values were cast to int without a warning (unless you specified the `--strict` option).

In RVCT v2.2 and later, a Warning is issued for out-of-range enumerator values:

```

#66: enumeration value is out of "int" range

```

Such values are treated the same way as in C++, that is, they are treated as unsigned int, long long, or unsigned long long.

To ensure that out-of-range Warnings are reported, use the following command to change them into Errors:

```

armcc --diag_error=66 ...

```

## Structures

The following points apply to:

- all C structures
  
- all C++ structures and classes not using virtual functions or base classes.
  

Structure alignment

The alignment of a nonpacked structure is the maximum alignment required by any of its fields.

Field alignment

Structures are arranged with the first-named component at the lowest address. Fields are aligned as follows:

- A field with a char type is aligned to the next available byte.
  
- A field with a short type is aligned to the next even-addressed byte.
  
- In RVCT v2.0 and above, double and long long data types are eight-byte aligned. This enables efficient use of the `LDRD` and `STRD` instructions in ARMv5TE and above.
  
- Bitfield alignment depends on how the bitfield is declared. See [_Bitfields in packed structures_](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babcgedf "Bitfields in packed structures") for more information.
  
- All other types are aligned on word boundaries.
  

Structures can contain padding to ensure that fields are correctly aligned and that the structure itself is correctly aligned. [Figure 3](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babcbhch "Figure 3. Conventional nonpacked structure example") shows an example of a conventional, nonpacked structure. Bytes 1, 2, and 3 are padded to ensure correct field alignment. Bytes 11 and 12 are padded to ensure correct structure alignment. The `sizeof()` function returns the size of the structure including padding.

**Figure 3. Conventional nonpacked structure example**

[![Figure 3. Conventional nonpacked structure example](blob:https://developer.arm.com/ac4e0d8a-b721-4db6-8c79-9476a77b6f28)](https://documentation-service.arm.com/static/5f90173ef86e16515cdc13c1?token=)

  

The compiler pads structures in one of the following ways, according to how the structure is defined:

- Structures that are defined as static or extern are padded with zeros.
  
- Structures on the stack or heap, such as those defined with `malloc()` or auto, are padded with whatever is previously stored in those memory locations. You cannot use `memcmp()` to compare padded structures defined in this way (see [Figure 3](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babcbhch "Figure 3. Conventional nonpacked structure example")).
  

Use the `--remarks` option to view the messages that are generated when the compiler inserts padding in a struct.

Structures with empty initializers are permitted in C++:

```

struct

{

    int x;

} X = { };

```

However, if you are compiling C, or compiling C++ with the `--cpp` and`--c90` options, an error is generated.

## Packed structures

A packed structure is one where the alignment of the structure, and of the fields within it, is always 1.

You can pack specific structures with the `__packed` qualifier. Alternatively, you can use `#pragma pack(_n_)` to make sure that any structures with unaligned data are packed. There is no command-line option to change the default packing of structures.

## Bitfields

In nonpacked structures, the ARM compiler allocates bitfields in _containers_. A container is a correctly aligned object of a declared type.

Bitfields are allocated so that the first field specified occupies the lowest-addressed bits of the word, depending on configuration:

Little-endian

Lowest addressed means least significant.

Big-endian

Lowest addressed means most significant.

A bitfield container can be any of the integral types.

> ### Note
> 
> In strict 1990 ISO Standard C, the only types permitted for a bit field are int, signed int, and unsigned int. For non-int bitfields, the compiler displays an error.

A plain bitfield, declared without either signed or unsigned qualifiers, is treated as unsigned. For example, `int x:10` allocates an unsigned integer of 10 bits.

A bitfield is allocated to the first container of the correct type that has a sufficient number of unallocated bits, for example:

```

struct X

{

    int x:10;

    int y:20;

};

```

The first declaration creates an integer container and allocates 10 bits to `x`. At the second declaration, the compiler finds the existing integer container with a sufficient number of unallocated bits, and allocates `y` in the same container as `x`.

A bitfield is wholly contained within its container. A bitfield that does not fit in a container is placed in the next container of the same type. For example, the declaration of `z` overflows the container if an additional bitfield is declared for the structure:

```

struct X

{

    int x:10;

    int y:20;

    int z:5;

};

```

The compiler pads the remaining two bits for the first container and assigns a new integer container for `z`.

Bitfield containers can _overlap_ each other, for example:

```

struct X

{

    int x:10;

    char y:2;

};

```

The first declaration creates an integer container and allocates 10 bits to `x`. These 10 bits occupy the first byte and two bits of the second byte of the integer container. At the second declaration, the compiler checks for a container of type char. There is no suitable container, so the compiler allocates a new correctly aligned char container.

Because the natural alignment of char is 1, the compiler searches for the first byte that contains a sufficient number of unallocated bits to completely contain the bitfield. In the example structure, the second byte of the int container has two bits allocated to `x`, and six bits unallocated. The compiler allocates a char container starting at the second byte of the previous int container, skips the first two bits that are allocated to `x`, and allocates two bits to `y`.

If `y` is declared `char y:8`, the compiler pads the second byte and allocates a new char container to the third byte, because the bitfield cannot overflow its container. [Figure 4](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babbfgad "Figure 4. Bitfield allocation 1") shows the bitfield allocation for the following example structure:

```

struct X

{

    int x:10;

    char y:8;

};

```

**Figure 4. Bitfield allocation 1**


![64756c0b23c4e0c2a34a92a62a30a9e2_MD5](https://github.com/user-attachments/assets/d1bd255c-d9c1-450f-874b-6da6c2eec954)

  

> ### Note
> 
> The same basic rules apply to bitfield declarations with different container types. For example, adding an int bitfield to the example structure gives:

> ```
> 
> struct X
> 
> {
> 
>     int x:10;
> 
>     char y:8;
> 
>     int z:5;
> 
> }
> 
> ```

The compiler allocates an int container starting at the same location as the `int x:10` container and allocates a byte-aligned char and 5-bit bitfield, see [Figure 5](https://developer.arm.com/documentation/dui0491/i/C-and-C---Implementation-Details/Structures--unions--enumerations--and-bitfields?lang=en#Babfdbfi "Figure 5. Bitfield allocation 2").

**Figure 5. Bitfield allocation 2**


![c7bd13fb3da7285fae54080d1437776f_MD5](https://github.com/user-attachments/assets/f1d3f89f-f738-4064-9886-b698481b91b9)




You can explicitly pad a bitfield container by declaring an unnamed bitfield of size zero. A bitfield of zero size fills the container up to the end if the container is not empty. A subsequent bitfield declaration starts a new empty container.

> ### Note
> 
> As an optimization, the compiler might overwrite padding bits in a container with unspecified values when a bitfield is written. This does not affect normal usage of bitfields.

## Bitfields in packed structures

Bitfield containers in packed structures have an alignment of 1. Therefore, the maximum bit padding for a bitfield in a packed structure is 7 bits. For an unpacked structure, the maximum padding is `8*sizeof(container-type)-1 bits`.



The C standard doesn’t define how bit fields should be ordered. In fact, it says: [“The order of allocation of bit-fields within a unit (high-order to low-order or low-order to high-order) is implementation-defined.”](http://c0x.coding-guidelines.com/6.7.2.1.html)

Going by that, we have no way to know if pllLock will end up in the most significant bit like we expect it to, or the least significant bit. Things get even more complicated when you throw in larger bit fields on 32 or 64 bit machines, endianness, and padding for fields that cross storage boundaries. If you’re interested in portable code, you’re better off with the other method, shift and mask, which I describe below.

bitfield-structs come with some limitations:

1. Bit fields result in non-portable code. Also, the bit field length has a high dependency on word size.
2. Reading (using `scanf()`) and using pointers on bit fields is not possible due to non-addressability.
3. Bit fields are used to pack more variables into a smaller data space, but cause the compiler to generate additional code to manipulate these variables. This results in an increase in both space as well as time complexities.
4. The `sizeof()` operator cannot be applied to the bit fields, since `sizeof()` yields the result in bytes and not in bits.
5. As far as I understand, bitfields are purely compiler constructs
6. Things get even more complicated when you throw in larger bit fields on 32 or 64 bit machines, endianness, and padding for fields that cross storage boundaries.
7.  If you’re interested in portable code, you’re better off with the other method, shift and mask.e zero. A bitfield of zero size fills the container up to the end if the container is not empty. A subsequent bitfield declaration starts a new empty container.

> ### Note
> 
> As an optimization, the compiler might overwrite padding bits in a container with unspecified values when a bitfield is written. This does not affect normal usage of bitfields.

## Bitfields in packed structures

Bitfield containers in packed structures have an alignment of 1. Therefore, the maximum bit padding for a bitfield in a packed structure is 7 bits. For an unpacked structure, the maximum padding is `8*sizeof(container-type)-1 bits`.



The C standard doesn’t define how bit fields should be ordered. In fact, it says: [“The order of allocation of bit-fields within a unit (high-order to low-order or low-order to high-order) is implementation-defined.”](http://c0x.coding-guidelines.com/6.7.2.1.html)

Going by that, we have no way to know if pllLock will end up in the most significant bit like we expect it to, or the least significant bit. Things get even more complicated when you throw in larger bit fields on 32 or 64 bit machines, endianness, and padding for fields that cross storage boundaries. If you’re interested in portable code, you’re better off with the other method, shift and mask, which I describe below.

bitfield-structs come with some limitations:

1. Bit fields result in non-portable code. Also, the bit field length has a high dependency on word size.
2. Reading (using `scanf()`) and using pointers on bit fields is not possible due to non-addressability.
3. Bit fields are used to pack more variables into a smaller data space, but cause the compiler to generate additional code to manipulate these variables. This results in an increase in both space as well as time complexities.
4. The `sizeof()` operator cannot be applied to the bit fields, since `sizeof()` yields the result in bytes and not in bits.
5. As far as I understand, bitfields are purely compiler constructs
6. Things get even more complicated when you throw in larger bit fields on 32 or 64 bit machines, endianness, and padding for fields that cross storage boundaries.
7.  If you’re interested in portable code, you’re better off with the other method, shift and mask.
8.  Explicitly declare all padding positions and disable automatic padding
9.  avoid bit-field to cross byte boundary
10. Must do bit-field sanity check before using
