#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say signatures);
no warnings qw(experimental::signatures);
use List::Util qw(reduce);

sub shift_position($x, $y, $width, $x_offset, $y_offset) {
  return (($x + $x_offset) % $width, $y + $y_offset)
}

sub do_slope_run($x_offset, $y_offset, @lines) {
  my $height   = @lines;
  my $line     = $lines[0];
  my $width    = split(//, $line);
  my $trees    = 0;
  my ($x, $y) = (0, 0);

  while($y < @lines) {
    my @line = split(//, $lines[$y]);
    my $char = $line[$x];
    $trees++ if ($char eq '#');
    ($x, $y) = shift_position($x, $y, $width, $x_offset, $y_offset);
  }

  say "Trees hit for offset by ($x_offset, $y_offset): $trees";
  return $trees;
}

sub solve_part1($file_path) {
  say "Solving file: $file_path";

  open my $FH, "<", $file_path or die $!;
  my @lines = <$FH>;
  for (@lines) {
    $_ =~ s/\s+$//;
  }
  close $FH;

  my @results = (
    do_slope_run(1, 1, @lines),
    do_slope_run(3, 1, @lines),
    do_slope_run(5, 1, @lines),
    do_slope_run(7, 1, @lines),
    do_slope_run(1, 2, @lines),
  );
  say reduce {$a*$b} @results;
}

solve_part1($_) for (@ARGV)
