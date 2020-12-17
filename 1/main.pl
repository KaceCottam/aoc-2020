#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

sub solve_file($) {
  my $filename = shift;
  say "Solving for file $filename";
  open my $infile < $filename or die "Bad file $filename: $!";
  my @lines = <$infile>;
  close $infile;
  my @numbers = map {scalar($_)} @lines;
  for my $i (@numbers) {
    for my $j (@numbers) {
      say $i * $j and return if $i + $j eq 2020;
    }
  }
}

solve_file($_) for @ARGV;
