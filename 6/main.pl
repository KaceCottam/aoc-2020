#!/usr/bin/env perl
use strict;
use warnings;
use 5.030;
use List::Util qw(reduce sum uniq);

sub countit_1 {
  my @letters = uniq (split (//, shift));
  my $length = @letters;
  return $length;
}

sub solve_file_1 {
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
    push @accumulator, $line;
  }

  say sum map {countit_1($_)} @accumulator;
}

sub countit {
  my $line = shift;
  my @people = split(/\s/, $line);
  my $persons = @people;
  my %seen = map { $_ => 0 } split(//,"abcdefghijklmnopqrstuvwxyz");
  for (@people) {
    my @answers = split(//, $_);
    for (@answers) {
      $seen{$_}++;
    }
  }
  my $value = 0;
  for (values %seen) {
    $value++ if $_ == $persons
  }
  return $value;
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

  say sum map {countit($_)} @accumulator;
}

solve_file($_) for @ARGV
