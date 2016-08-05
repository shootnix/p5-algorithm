package List;

use strict;
use warnings;
use 5.010;


sub search1 {
	my ($list, $val) = @_;

	for (@$list) {
		return 1 if $_ == $val;
	}

	return;
}


my $l = 0; my $r = undef; ## TODO: state variables
sub search2 {
	my ($list, $val) = @_;

	$r = scalar @$list - 1 unless $r;

	my $mid  = int(($l + $r) / 2);

	my $cmp_val = $list->[$mid];
	return 1 if $val == $cmp_val;

	if ($val > $cmp_val) {
		$l = $mid;
	}
	else {
		$r = $mid;
	}

	return $list->[$r] == $val if $r - $l == 1;

	return search2($list, $val);
	return;
}



1;