#!/usr/bin/env perl
use strict;
use warnings;
use 5.030;
use List::Util qw(reduce max);

my $rows    = 128;
my $columns = 8;

sub get_seat_id {
  my ($row, $column) = @_;
  return $row * 8 + $column;
}

sub bin_search {
  my ($min, $max, $position, $U, $line) = @_;
  for (split(//, $line)) {
    if ($_ eq $U) {
      $max = $position;
    } else {
      $min = $position;
    }
    $position = ($max - $min) / 2 + $min;
  }
  return $min;
}

sub get_column {
  bin_search(0, $columns, $columns / 2, "L", shift);
}

sub get_row {
  bin_search(0, $rows, $rows / 2, "F", shift);
}

sub line_to_sid {
  if (m/([FB]{7})([LR]{3})/) {
    my $row    = get_row($1);
    my $column = get_column($2);
    return get_seat_id($row, $column);
  }
  return undef;
}

sub line_to_row {
  if (m/([FB]{7})([LR]{3})/) {
    return get_row($1);
  }
  return undef;
}

sub line_to_col {
  if (m/([FB]{7})([LR]{3})/) {
    return get_column($1);
  }
  return undef;
}

sub solve_file {
  my $file_path = shift;
  say "Solving file: $file_path";
  open my $FH, "<", $file_path or die $!;
  my @lines = <$FH>;
  chomp for (@lines);
  close $FH;

  #my @seat_row = map { line_to_row($_) } @lines;
  #my @seat_col = map { line_to_col($_) } @lines;
  my @seat_ids = map { line_to_sid($_) } @lines;
  say for (@seat_ids);
  my $highest = max @seat_ids;
  say $highest;
}

solve_file($_) for @ARGV
