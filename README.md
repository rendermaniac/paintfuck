# What is Brainfuck?

Brainfuck is an [esoteric language](https://esolangs.org/wiki/Brainfuck) with very few operators that is Turing complete. In fact it bears a lot of resemblance to a Turing machine. The operators are:

| Operator | Description |
--- | ---
|+|Increment the current cell by one|
|-|Decrement the current cell by one|
|<|Move one cell to the left|
|>|Move one cell to the right|
|\[|Start a loop. Jump to the next \] when current cell is zero|
|\]|End a loop. Jump to the previous \[|

# Why brainfuck?!

The obvious answer is why not!

It seemed like an interesting exercise to generate images using brainfuck and I couldn't find an example of it done before.

There are some very impressive examples (far more so than mine!) available online - such as [ASCII mandelbrot fractals](https://copy.sh/brainfuck/?file=https://copy.sh/brainfuck/prog/mandelbrot.b) and [Conway's Game of Life](https://www.linusakesson.net/programming/brainfuck/index.php).

# Brainfuck specific Issues

## No variables

We only have a single pointer to the current cell value. This makes finding other values hard as we need to know how many cells we need to jump to get to the next value

## No Basic maths operators!

We can only increment and decrement a value as built in operators. If we want to add or multiply two cell values we need to program this ourselves - and this often needs several temporary cells. Most of these are easy to find examples - such as [multiplication](
https://stackoverflow.com/questions/5165772/code-for-multiplying-two-one-digit-numbers-in-brainfuck) on Stack Overflow.

## Storing program data

The problems of no variables and having to write your own operators means that it can be hard to store data without corrupting it from an operation. For this reason I switched from shortened values using addition to writing them out in full - so as not to need multiple cells.

This is also the reason for jumping to the end of a buffer and then filling it in backwards - so that we do not need to calculate our current position (which would require generating temporary data and jumping between cells).

## ASCII

It is important to remember that Brainfuck takes input and output as ASCII characters - which are then stored as ASCII codes in cells. This means that to output a zero you need to print the value 48. Having the ASCII code table handy is invaluable!

https://www.ascii-code.com/

I chose to store actual values on the tape, and only convert from/to ASCII for input/output as this made it easier to visualize.

# Tools

The most useful tool I could find was this debugging interpreter

https://fatiherikli.github.io/brainfuck-visualizer/

It has the advantage that you can see the operations operating on the tape in real time as it runs through the program. You can even single step - which is incredibly handy. The only disadvantages of this tool are that it can be a bit slow if you are waiting to get to a particular part of the code, and the tape size if quite limited so it is easy to run out of memory. But it is also easy to see why you are having memory errors when you run off either end of the tape!

All interpreters I used are wrapping - this means the cell gets set to 255 if you decrement a zero cell by one so this was never a problem, and seems quite common with brainfuck interpreters.

To run larger code, faster there is a great interpreter here, but it's disadvantage is that it gives you a lot less feedback about what the code is doing:

https://copy.sh/brainfuck/

They also have a handy tool to convert text to brainfuck - as it really does get boring quickly to look up each ASCI code individually if your code outputs a lot of text.

https://copy.sh/brainfuck/text.html

For an offline interpreter, I did start to write my own - as it really isn't that hard - but decided to download and extend an existing one in Python because it would already have all the bugs worked out. I used this one which is easy to understand and works well:

https://github.com/DoctorLai/PyUtils/blob/master/bf.py

My fork - included in this project just adds:

- Reading in bf files from disk
- Reading program input from the command line
- Outputting to a ppm file which gets written to when printing characters 

# What image format to use?

By necessity, brainfuck requires some features in any image format we want to write:

- it has to be very simple with as minimal a header as possible
- it has to be able to store ASCII data as we have no option of binary output (unless we post convert, but that is cheating a bit)

The [PPM image format](http://www.paulbourke.net/dataformats/ppm/) fits this bill perfectly with it's P3 ASCII format. The header has a single magic number, resolution and quantization and then pixel data.

One quirk of brainfuck is that each cell stores an integer, but we can only output single ASCII characters. This means that if we want to output a value higher than 9 then we need to print two characters. To do this we have 2 options:

- Determine the values by using modulus to split into hundreds, tens and units. This is probably the most robbust approach, but is complicated
- Use multiple cells to store values. This is much simpler to work with, but makes any image manipulation harder. This is the approach I took.

Purely because there aren't many image viewers for PPM format files, I converted the images for display into more common formats - such as BMP or JPEG using [Image Magick](https://imagemagick.org/).

# Generating images

## Four Pixels

My first attempt at writing an image using brainfuck was manually writing each value into the PPM image. Note that I use the short form for each character by calculating it by adding it's ASCII code factors. This is why it needs to jump 2 pointers each time as we use one cell for each factor:

(https://github.com/rendermaniac/paintfuck/blob/main/four_pixel.bf)

Note that any character that is not special is ignored by brainfuck, so adding comments is pretty easy.

This is the output from this program. If you zoom in a lot you can see that it contains a red, a green, a blue and a white pixel in a 2 by 2 pixel image.

![four pixel image generated by brainfuck](https://raw.githubusercontent.com/rendermaniac/paintfuck/main/four_pixel.jpg)

I then wanted to experiment with creating an image buffer and outputting it. This started with single characters:

[https://github.com/rendermaniac/paintfuck/blob/main/buffer_bit.bf](https://github.com/rendermaniac/paintfuck/blob/main/buffer_bit.bf)

The main loop used in this program comes directly from this amazing tutorial about [AI in brainfuck](https://www.youtube.com/watch?v=qK0vmuQib8Y). We could directly output the nujmber of positions to move the pointer forwards, but this gives us flexibility to allow inputing resolution values later (up to a staggering 4 by 4 pixels!)

I then built a data structure to store an 8 bit colour. This consists of:

- 1 cell to store the hundreds (or a space if missing)
- 1 cell to store the tens (or a space if missing)
- 1 cell to store the units
- 1 cell storing a space to seperate colours (potentially we could generate this only on output)

These use real numbers, not ascii, and the space character is stored minus 48 so that it gets output correctly when we offset the numbers to their ascii character. So White (255) would be stored as:

```brainfuck
+++++                  5
>+++++                 5
>++                    2
> ---- ---- ---- ---- -16
```

Because we write out the buffer from the end forwards, we store the colours reversed so that they can be visualized easily on the tape.

This was also where I encountered by first bit head scratching problem to debug. To stop the loop that fills in our cell values, we must end up with a zero in the final cell. To do this we initialize an anchor by decrementing it to exactly balance the last character of our structure - the space. It took me ages to realize that we need a full copy of the structure to end on (ie 4 junk cells before actual data) to be able to successfully stop the loop. Only the final cell matters so we fill the other cells with 255 (ie decrement once) to give us speed and not stop iteration by being zero. We then move the pointer to the start of the actual data for output.

Outputting the data is very simple - we iterate forwards through the buffer, adding 48 before outputting to the console (and to the ppm file).

```brainfuck
[
++++++++++
++++++++++
++++++++++
++++++++++
++++++++.> 
]
```

Finally we can use this knowledge to output full pixels. This program gets fancy and asks for user input using the ```,``` operator - so for a 2 by 2 pixel image you would pass in the string ```22``` at the command line. It would be possible to make larger images, but making a 16 pixel image was hard enough!

[https://github.com/rendermaniac/paintfuck/blob/main/buffer_pixel.bf](https://github.com/rendermaniac/paintfuck/blob/main/buffer_pixel.bf)

Which by default outputs the terribly exciting solid colour:

![Solid colour generated by brainfuck](https://raw.githubusercontent.com/rendermaniac/paintfuck/main/buffer_pixel.jpg)

Note that redirecting the image data to a file does not work on Windows. I haven't worked out why yet. I suspect line feed characters have something to do with it, but Imagemagick complains about an invalid header file. I have not tried this on Linux yet.

# Procedural Patterns

It should be possible to generate some procedural patterns using brainfuck by using multiple passes to fill the image buffer. Potential extension ideas are:

- Split image colours horizontally
- Split image colours vertically
- Split image colours diagonally
- Checkerboard pattern
- Cross
- Quarter circle - using pythagoras
- Full Circle

## Raytracing in Brainfuck

Could it be done? I am sure it could! Am I going to do it? Probably not. To get this working the easiest starting point would be to write it in another language and use one of the many compilers available to convert it to brainfuck. Understanding anything to debug in brainfuck would really make the language live up to it's name. I would love to see someone try this though!
