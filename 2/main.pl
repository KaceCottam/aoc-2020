#!/usr/bin/env perl
use strict;
use warnings;
use 5.30.0;
use List::Util qw(reduce);

sub solve_file_part2($) {
  my $file_path = shift;
  say "Solving file $file_path";
  open my $FH < $file_path or die "Bad file! $!";
  my @lines = <$FH>;
  close $FH;
  our $matching = 0;
  for (@lines) {
    if ($_ =~ '(\d+)-(\d+) (\w): (\w+)') {
      my $pos1 = scalar($1) - 1;
      my $pos2 = scalar($2) - 1;
      my $char = $3;
      my $pass = $4;
      my @split_pass = split(//, $pass);
      $matching++ if  $split_pass[$pos1] ne $split_pass[$pos2]
                  and ($split_pass[$pos1] eq $char || $split_pass[$pos2] eq $char);
    }
  }
  say "Matching: $matching";
}

sub solve_file_part1($) {
  my $file_path = shift;
  say "Solving file $file_path";
  open my $FH < $file_path or die "Bad file! $!";
  my @lines = <$FH>;
  close $FH;
  our $matching = 0;
  for (@lines) {
    if ($_ =~ '(\d+)-(\d+) (\w): (\w+)') {
      my $lower  = scalar($1);
      my $upper  = scalar($2);
      my $char   = $3;
      my $pass   = $4;

      my @split_pass = split(//, $pass);

      my $count = reduce { $a + ($b eq $char ? 1 : 0) } (0, @split_pass);

      #say "lower $1, upper $2, char: $3, pass: $4";
      say "count: $count";

      if ($lower <= $count && $count <= $upper) {
        $matching++;
      }
    }
  }
  say "Matching: $matching";
}

solve_file_part1($_) for (@ARGV)
