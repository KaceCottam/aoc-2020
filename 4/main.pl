#!/usr/bin/env perl

use strict;
use warnings;
use 5.030;
use List::Util qw(reduce sum);


sub byr_check {
  my $value = shift;
  return (1920 <= $value and $value <= 2002)
}
sub iyr_check {
  my $value = shift;
  return (2010 <= $value and $value <= 2020)
}
sub eyr_check {
  my $value = shift;
  return (2020 <= $value and $value <= 2030)
}
sub hgt_check {
  my $value = shift;
  if ($value =~ m/(\d+)cm/) {
    return (150 <= $1 and $1 <= 193)
  }
  if ($value =~ m/(\d+)in/) {
    return (59 <= $1 and $1 <= 76)
  }
}
sub hcl_check {
  my $value = shift;
  return ($value =~ m/#[0-9a-f]{6}/)
}
sub ecl_check {
  my $value = shift;
  my %allowed = map { $_ => 1 } qw(amb blu brn gry grn hzl oth);
  return exists($allowed{$value})
}
sub pid_check {
  my $value = shift;
  return ($value =~ m/^\d{9}$/)
}

sub is_valid {
  my $line = shift;
  my @checks = qw(byr iyr eyr hgt hcl ecl pid);
  my $checklen = @checks;
  my $valid = 0;

  $valid++ if (" $line " =~ m/byr:(.*?)\s/) and (byr_check($1));
  $valid++ if (" $line " =~ m/iyr:(.*?)\s/) and (iyr_check($1));
  $valid++ if (" $line " =~ m/eyr:(.*?)\s/) and (eyr_check($1));
  $valid++ if (" $line " =~ m/hgt:(.*?)\s/) and (hgt_check($1));
  $valid++ if (" $line " =~ m/hcl:(.*?)\s/) and (hcl_check($1));
  $valid++ if (" $line " =~ m/ecl:(.*?)\s/) and (ecl_check($1));
  $valid++ if (" $line " =~ m/pid:(.*?)\s/) and (pid_check($1));

  return $valid == $checklen
}

sub solve_file {
  say "Solving file: $_";
  open my $FH, "<", shift or die $!; 
  my @lines = <$FH>;
  chomp for @lines;
  close $FH;

  my @accumulator = ( "" );
  for (@lines) {
    push @accumulator, "" and next if $_ eq "";
    my $acc  = pop @accumulator;
    my $line = "$acc $_";
    $line =~ s/^\s+|\s+$//g;
    push @accumulator, $line;
  }
  say sum map {is_valid($_)} @accumulator;
}

solve_file($_) for @ARGV
