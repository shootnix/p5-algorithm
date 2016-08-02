#!/usr/bin/env perl


use strict;
use warnings;
use 5.010;

use Data::Dumper;
use Test::More;

use FindBin qw/$Bin/;
use lib "$Bin/../lib";


use_ok('LinkedList');
eval { LinkedList->new };
ok $@ ne q//;
like $@, qr/list is required/i;
eval { LinkedList->new(list => []) };
ok $@ ne q//;
like $@, qr/type of list is required/i;
eval { LinkedList->new(list => [], type => 'invalid_type') };
ok $@ ne q//;
like $@, qr/unknown type/i;

ok my $list1 = LinkedList->new(list => [qw/1 2 3/], type => 'onedirect_unsorted');
is $list1->item, 1;
is $list1->next->item, 2;
ok $list1->search(2), 'search 2 is ok';
ok $list1->search(2)->item == 2;
ok !$list1->search(100), 'search 100 is not ok';
ok $list1->insert(100), 'insert 100';
ok $list1->search(100), 'now search 100 is ok';
ok $list1->_predecessor(2), '_predecessor';
is $list1->_predecessor(2)->item, 1;


ok $list1->del(100), 'del';
ok !$list1->search(100), 'del 100 ok';

ok my $list2 = LinkedList->new(list => [qw/3 1 2/], type => 'onedirect_sorted');
is $list2->item, 1;
is $list2->next->item, 2;
is $list2->next->next->item, 3;

ok my $list3 = LinkedList->new(list => [qw/1 2 3/], type => 'bidirect_unsorted');
ok $list3->item == 1;
ok !$list3->prev;
is $list3->next->item, 2;
is $list3->next->next->item, 3;
is $list3->next->next->prev->item, 2;


done_testing();