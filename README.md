# KindleClippings [![Build Status](https://travis-ci.org/domnikl/kindle-clippings.svg?branch=master)](https://travis-ci.org/domnikl/kindle-clippings)

Generates a beautiful report from a Kindle clipping file `My Clippings.txt`.

## Installation

```
git clone https://github.com/domnikl/kindle-clippings.git
cd kindle-clippings
mix escript.build
```

## Usage

```
cat "My Clippings.txt" | ./kindle_clippings > clippings.html
```

## License

(The MIT License)

Copyright (c) 2016 Dominik Liebler

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
