PPM ascii header
P
++++++++++
++++++++++
++++++++++
++++++++++
++++++++++
++++++++++
++++++++++
++++++++++
.

> 3
++++++++++
++++++++++
++++++++++
++++++++++
++++++++++
+
.

> space
++++++++++
++++++++++
++++++++++
++
.

width: 2
> ++
++++++++++
++++++++++
++++++++++
++++++++++
++++++++
.

> space
++++++++++
++++++++++
++++++++++
++
.

height: 2
>++
++++++++++
++++++++++
++++++++++
++++++++++
++++++++
.

> space
++++++++++
++++++++++
++++++++++
++
.

Output 8 bit quantization header info
> 2
++++++++++
++++++++++
++++++++++
++++++++++
++++++++++
.

> 5
++++++++++
++++++++++
++++++++++
++++++++++
++++++++++
+++
.

> 5
++++++++++
++++++++++
++++++++++
++++++++++
++++++++++
+++
.

> LF
++++++++++
.

Setup anchors to stop walk
We need the same number as components: in this case 12 (4 components x 3 colours)
Only the first one needs to cancel to zero with the last character added: the space

>++++ ++++ ++++ ++++
>+>+>+>+
>+>+>+>+
>+>+>+>+

>+>+>+>+
>+>+>+>+
>+>+>+>+

Jump forwards 4 pixels
>>>> >>>> >>>> >>>> >>>> >>>>
>>>> >>>> >>>> >>>> >>>> >>>>

Some value is needed here or the loop will stop instantly
Line Feed
------------------------------------

We are now at the end of our buffer so we can start filling it backwards

Pixel Data
[
    <+++++                  5
    <+++++                  5 
    <++                     2
    <---- ---- ---- ----    space

    <+++++                  5
    <+++++                  5 
    <++                     2
    <---- ---- ---- ----    space

    <+++++                  5
    <+++++                  5 
    <++                     2
    <---- ---- ---- ----    space

    Note that we can't actually use zero as this will stop the iteration!
    This may be a case where storing ascii characters may work better
    <+                      1
    <---- ---- ---- ----    space
    <---- ---- ---- ----    space
    <---- ---- ---- ----    space

    <+                      1
    <---- ---- ---- ----    space
    <---- ---- ---- ----    space
    <---- ---- ---- ----    space

    <+                      1
    <---- ---- ---- ----    space
    <---- ---- ---- ----    space
    <---- ---- ---- ----    space
    
]

Take us back to the start of the data
>>>> >>>> >>>> >>>>
>>>> >>>>

Convert to ascii by adding 48 (ascii zero) and print buffer
>
[
++++++++++
++++++++++
++++++++++
++++++++++
++++++++.>
]