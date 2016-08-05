#!/usr/bin/env perl


use strict;
use warnings;
use 5.010;
use Test::More;

use FindBin qw/$Bin/;
use lib "$Bin/../lib";


my @list = 0..50_000_000;


use_ok('List');
ok(List::search1(\@list, 10_000));
ok(!List::search1(\@list, -1));
ok(List::search2(\@list, 10_000));
ok(!List::search2(\@list, -1));


done_testing();