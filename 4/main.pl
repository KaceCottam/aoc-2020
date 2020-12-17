#!/usr/bin/env perl

use strict;
use warnings;
use 5.030;
use List::Util qw(reduce sum);

my $verbose = shift;

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
  if (" $line " =~ m/byr:(.*?)\s/) {
    if (byr_check($1)) {
      $valid++;
      say "byr valid $1" if $verbose
    } else {
      say "byr invalid" if $verbose
    }
  }
  if (" $line " =~ m/iyr:(.*?)\s/) {
    if (iyr_check($1)) {
      $valid++;
      say "iyr valid $1" if $verbose
    } else {
      say "iyr invalid" if $verbose
    }
  }
  if (" $line " =~ m/eyr:(.*?)\s/) {
    if (eyr_check($1)) {
      $valid++;
      say "eyr valid $1" if $verbose
    } else {
      say "eyr invalid" if $verbose
    }
  }
  if (" $line " =~ m/hgt:(.*?)\s/) {
    if (hgt_check($1)) {
      $valid++;
      say "hgt valid $1" if $verbose
    } else {
      say "hgt invalid" if $verbose
    }
  }
  if (" $line " =~ m/hcl:(.*?)\s/) {
    if (hcl_check($1)) {
      $valid++;
      say "hcl valid $1" if $verbose
    } else {
      say "hcl invalid" if $verbose
    }
  }
  if (" $line " =~ m/ecl:(.*?)\s/) {
    if (ecl_check($1)) {
      $valid++;
      say "ecl valid $1" if $verbose
    } else {
      say "ecl invalid" if $verbose
    }
  }
  if (" $line " =~ m/pid:(.*?)\s/) {
    if (pid_check($1)) {
      $valid++;
      say "pid valid $1" if $verbose
    } else {
      say "pid invalid $1" if $verbose
    }
  }
  say "valid $valid" if $verbose;
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
