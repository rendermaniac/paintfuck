Setup anchors to stop walk
Note that this cancels out the space: the last character added
-

> Number of components
++++
++++
++++
++++

We have 4 components per colour: one is a space character
And three colours per pixel
This gives a maximum of 16 pixels
-[-[-[-[
-[-[-[-[
-[-[-[-[
-[-[-[-

>]>]>]>]
>]>]>]>]
>]>]>]>]
>]>]>]>

We are now at the end of our buffer so we can start filling it backwards

Line Feed
----------
----------
----------
------

Pixel Data
[
    <+
]

Convert to ascii by adding 48 (ascii zero) and print buffer
>
[
++++++++++
++++++++++
++++++++++
++++++++++
++++++++.> 
]