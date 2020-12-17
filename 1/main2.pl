#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use List::Util qw(reduce);

sub solve_file($) {
  my $filename = shift;
  say "Solving for file $filename";
  open my $infile, "<", $filename or die "Bad file $filename: $!";
  my @lines = <$infile>;
  my @numbers = map {scalar($_)} @lines;
  for my $i (@numbers) {
    for my $j (@numbers) {
      for my $k (@numbers) {
        say $i * $j * $k and return if $i + $j + $k eq 2020;
      }
    }
  }
  close $infile
}

solve_file($_) for @ARGV;
