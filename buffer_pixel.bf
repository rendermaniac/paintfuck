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

> input width
,
.
----------
----------
----------
----------
--------

> space
++++++++++
++++++++++
++++++++++
++
.
[-] clear cell

height
,
.
----------
----------
----------
----------
--------

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
#
clear cells back to height
[-]<[-]<[-]<[-]<[-]<

Multiply width and height from stackoverflow
<[>[>+>+<<-]>>[<<+>>-]<<<-]>>

Setup anchors to stop walk
We need the same number as components: in this case 12 (4 components x 3 colours)
Only the first one needs to cancel to zero with the last character added: the space
<-<-<-<-
<-<-<-<-
<-<-<-
<++++ ++++ ++++ ++++

Jump back to counter
>>>> >>>> >>>>

We have 4 components per colour: one is a space character
And three colours per pixel
This gives a maximum of 16 pixels
-[-[-[-[
-[-[-[-[
-[-[-[-[
-[-[-[-

>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>]
>>>> >>>> >>>>

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

    <++++++++               8
    <++                     2 
    <+                      1
    <---- ---- ---- ----    space

    <++++                   4
    <++++++                 6 
    <---- ---- ---- ----    space
    <---- ---- ---- ----    space
]

Take us back to the start of the data
>>>> >>>> >>>

Convert to ascii by adding 48 (ascii zero) and print buffer
>
[
++++++++++
++++++++++
++++++++++
++++++++++
++++++++.> 
]