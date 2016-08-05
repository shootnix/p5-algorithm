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

say Dumper $tree;

done_testing();