Setup anchors to stop walk
We need the same number as components
Only the first one needs to cancel to zero with the last character added: the space
>++++ ++++ ++++ ++++
>-
>-
>-

Number of components (16)
>++++ ++++ ++++ ++++

We have 4 components per colour:
3 characters to let us get to the maximum 8 bit 255 value
and one space to differentiate values
-[-[-[-[
-[-[-[-[
-[-[-[-[
-[-[-[-

>>>>]>>>>]>>>>]>>>>]
>>>>]>>>>]>>>>]>>>>]
>>>>]>>>>]>>>>]>>>>]
>>>>]>>>>]>>>>]>>>>

Some value is needed here or the loop will stop instantly
Line Feed
----------
----------
----------
------

We are now at the end of our buffer so we can start filling it backwards with our pixel data
[
    <+++++                  5
    <+++++                  5 
    <++                     2
    <---- ---- ---- ----    space
]

Move to first data cell
>>>

Convert to ascii by adding 48 (ascii zero) and print buffer
>
[
++++++++++
++++++++++
++++++++++
++++++++++
++++++++.> 
]