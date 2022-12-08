#!/usr/bin/env raku

# See "GNU Scientific Library" manual Chapter 33 Series Acceleration, Paragraph 33.3

use NativeCall;
use lib 'lib';
use Math::Libgsl::Raw::Series;

constant \N = 20;

my $t = CArray[num64].allocate(N);
my num64 $sum_accel;
my num64 $err;
my num64 $sum = 0e0;

my gsl_sum_levin_u_workspace $w = gsl_sum_levin_u_alloc(N);

constant \zeta_2 = π * π / 6e0;

for ^N -> $n {
  my num64 $np1 = $n + 1e0;
  $t[$n] = 1e0 / ($np1 * $np1);
  $sum += $t[$n];
}

gsl_sum_levin_u_accel($t, N, $w, $sum_accel, $err);

printf("term-by-term sum = %.16f using %d terms\n", $sum, N);
printf("term-by-term sum = %.16f using %u terms\n", $w.sum_plain, $w.terms_used);
printf("exact value      = %.16f \n", zeta_2);
printf("accelerated sum  = %.16f using %u terms\n", $sum_accel, $w.terms_used);
printf("estimated error  = %.16f \n", $err);
printf("actual error     = %.16f \n", $sum_accel - zeta_2);

gsl_sum_levin_u_free($w);
