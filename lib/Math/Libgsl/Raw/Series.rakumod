use v6;

unit module Math::Libgsl::Raw::Series:ver<0.0.1>:auth<zef:FRITH>;

use NativeCall;

sub LIB {
  run('/sbin/ldconfig', '-p', :chomp, :out)
    .out
    .slurp(:close)
    .split("\n")
    .grep(/^ \s+ libgsl\.so\. \d+ /)
    .sort
    .head
    .comb(/\S+/)
    .head;
}

class gsl_sum_levin_u_workspace is repr('CStruct') is export {
  has size_t        $.size;
  has size_t        $.i;
  has size_t        $.terms_used;
  has num64         $.sum_plain;
  has CArray[num64] $.q_num;
  has CArray[num64] $.q_den;
  has CArray[num64] $.dq_num;
  has CArray[num64] $.dq_den;
  has CArray[num64] $.dsum;
}

class gsl_sum_levin_utrunc_workspace is repr('CStruct') is export {
  has size_t        $.size;
  has size_t        $.i;
  has size_t        $.terms_used;
  has num64         $.sum_plain;
  has CArray[num64] $.q_num;
  has CArray[num64] $.q_den;
  has CArray[num64] $.dsum;
}

sub gsl_sum_levin_u_alloc(size_t $n --> gsl_sum_levin_u_workspace) is native(LIB) is export { * }
sub gsl_sum_levin_u_free(gsl_sum_levin_u_workspace $w) is native(LIB) is export { * }
sub gsl_sum_levin_u_accel(CArray[num64] $array, size_t $n, gsl_sum_levin_u_workspace $w, num64 $sum_accel is rw,
                          num64 $abserr is rw --> int32) is native(LIB) is export { * }
sub gsl_sum_levin_utrunc_alloc(size_t $n --> gsl_sum_levin_utrunc_workspace) is native(LIB) is export { * }
sub gsl_sum_levin_utrunc_free(gsl_sum_levin_utrunc_workspace $w) is native(LIB) is export { * }
sub gsl_sum_levin_utrunc_accel(CArray[num64] $array, size_t $n, gsl_sum_levin_utrunc_workspace $w,
                               num64 $sum_accel is rw, num64 $abserr_trunc is rw --> int32)
                               is native(LIB) is export { * }
