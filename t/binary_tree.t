#!/usr/bin/env perl


use strict;
use warnings;
use 5.010;
use Test::More;
use Data::Dumper;

use FindBin qw/$Bin/;
use lib "$Bin/../lib";


use_ok('BinaryTree');
ok my $tree = BinaryTree->new([4, 3, 6, 7, 4, 2]);
is $tree->min->item, 2;
is $tree->max->item, 7;
ok $tree->search(6);
ok !$tree->search(100);
ok $tree->traverse;


done_testing();