[![Actions Status](https://github.com/frithnanth/raku-Math-Libgsl-Series/actions/workflows/test.yml/badge.svg)](https://github.com/frithnanth/raku-Math-Libgsl-Series/actions)

NAME
====

Math::Libgsl::Series - An interface to libgsl, the Gnu Scientific Library - Series Acceleration

SYNOPSIS
========

```raku
use Math::Libgsl::Series;
```

SYNOPSIS
========

```raku
use Math::Libgsl::Series;

my Math::Libgsl::Series $s .= new: N;
constant \N = 20;
my @array := Array[Num].new;
(^N).map: -> $n { my $np1 = $n + 1e0; @array[$n] = 1e0 / ($np1 * $np1) }
my ($sum, $err) = $s.levin-accel: @array;
say "The series' sum is $sum, with an estimated error $err";
```

DESCRIPTION
===========

Math::Libgsl::Series is an interface to the Series Acceleration functions of libgsl, the Gnu Scientific Library.

### new(UInt:D() $size!, Bool $truncation? = False)

### new(UInt:D() :$size!, Bool :$truncation? = False)

The constructor accepts one or optionally two simple or named arguments: the mandatory series size and the optional error estimation type. This last argoment may have two values: propagation of rounding error or truncation error in the estrapolation. If the **Bool :$truncation** parameter is **True** then the error is estimated by means of the truncation error in the estrapolation. If the **Bool :$truncation** parameter is **False** then the error is estimated by means of the propagation of rounding errors.

### levin-accel(*@array where *.all > 0 --> List)

This method computes the extrapolated limit of the series using a Levin u-transform. It returns a **List**: the extrapolated **$sum**, the estimated **$error**, and the number of **$terms-used** during the computation.

C Library Documentation
=======================

For more details on libgsl see [https://www.gnu.org/software/gsl/](https://www.gnu.org/software/gsl/). The excellent C Library manual is available here [https://www.gnu.org/software/gsl/doc/html/index.html](https://www.gnu.org/software/gsl/doc/html/index.html), or here [https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf](https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf) in PDF format.

Prerequisites
=============

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

Debian Linux and Ubuntu 20.04+
------------------------------

    sudo apt install libgsl23 libgsl-dev libgslcblas0

That command will install libgslcblas0 as well, since it's used by the GSL.

Ubuntu 18.04
------------

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04. I solved the issue installing the Debian Buster version of those three libraries:

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb)

Installation
============

To install it using zef (a module management tool):

    $ zef install Math::Libgsl::Series

AUTHOR
======

Fernando Santagata <nando.santagata@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

