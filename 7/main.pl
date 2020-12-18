#!/usr/bin/env perl

use strict;
use warnings;
use 5.030;
use List::Util qw(uniq reduce);

sub line_to_dict {
  my $line = shift;
  my ($key, $value) = (split("contains?", $line));
  my @children = split(",", $value);
  for (@children) {s/^\s+|\s+$|bags?|\.//g}
  #print "$_ " for @children;
  my @list = ();
  for (@children) {
    if (m/(\d+)(.*)/) {
      unshift @list, [$1, $2]
    }
    else {
      unshift @list, [0, ""]
    }
  }
  for (@list) { @$_[1] =~ s/^\s+|\s+$//g };
  $key =~ s/ ?bags?|^\s+|\s+$//g;
  #say "[$key, @list]";
  return [$key, @list];
}

sub find_bag_in_bags {
  my ($bag, @bags) = @_;
  my @list_of_containers = ();
  for my $i (@bags) {
    my $bagname = shift @$i;

    # i  h a t e  this
    my %names = map {$_->[1] => 1} (@$i);
    if (exists($names{$bag})) {
      unshift @list_of_containers, $bagname;
    }

    unshift @$i, $bagname;
  }
  return @list_of_containers;
}

sub solve_file {
  my $file = shift;
  say "Solving file $file";
  open my $FH, "<", $file or die $!;
  my @lines = <$FH>;
  close $FH;

  my @dict = map {line_to_dict($_)} (@lines);

  #say "@$_" for @dict;
  my @containers = find_bag_in_bags("shiny gold", @dict);
  while (1) {
    my @new_containers = uniq (@containers, map {find_bag_in_bags($_, @dict)} @containers);
    last if (scalar @new_containers == scalar @containers);
    @containers = @new_containers;
  }
  say scalar @containers;
}

solve_file($_) for (@ARGV);
