package LinkedList;

use strict;
use warnings;

our $VERSION = 0.1;


use constant TYPES => ['onedirect_sorted', 'onedirect_unsorted', 'bidirect_sorted', 'bidirect_unsorted'];


# type:
#  - onedirect_sorted
#  - onedirect_unsorted
#  - bidirect_sorted
#  - bidirect_unsorted
sub new {
	my ($class, %opts) = @_;

	die "List is required param" unless $opts{list};
	die "Type of list is required param" unless $opts{type};
	die "Unknown type: $opts{type}" unless grep { $_ eq $opts{type} } @{&TYPES};

	$opts{list} = [sort @{ $opts{list} }] if $opts{type} =~ /_sorted$/;
	return $opts{type} =~ /^bidirect/ ? _create_bidirect($opts{list}) : _create_onedirect($opts{list});
}

sub _create_onedirect {
	my ($list) = @_;

	my @onedirect;
	my $next;

	while (my $list_item = pop @$list) {
		my $item = LinkedList::Item->new( type => 'onedirect', item => $list_item, next => $next );
		unshift @onedirect, $item;
		$next = $item;
	}

	return $onedirect[0];
}

sub _create_bidirect {
	my ($list) = @_;

	my ($next, $prev);
	my @bidirect = map { LinkedList::Item->new(item => $_, type => 'bidirect') } @$list;
	for (my $i=0; $i<@bidirect; $i++) {
		$bidirect[$i]->{next} = $bidirect[$i+1] if $i+1 < @bidirect;
		$bidirect[$i]->{prev} = $bidirect[$i-1] if $i-1 > 0;
	}

	return $bidirect[0];
}


### LinkedList::Item


package LinkedList::Item;


sub new {
	my ($class, %opts) = @_;

	my $self = \%opts;
	return bless $self, $class;
}

sub search {
	my ($self, $val) = @_;

	return unless defined $val && $self->item;
	return $self->item eq $val ? $self : ($self->next) ? $self->next->search($val) : undef;
}

sub insert {
	return unless defined $_[1];

	my $item = LinkedList::Item->new(item => $_[1], next => $_[0]);
	$_[0] = $item;
}

sub del {
	my ($self, $val) = @_;

	my $p = $self->search($val);
	if ($p) {
		my $pred = $self->_predecessor($val);
		if (!$pred) {
			$_[0] = $p->next;
		}
		else {
			$pred->{next} = $p->next;
		}
	}
}

sub item { shift->{item} }
sub next { shift->{next} }
sub prev { shift->{prev} }
sub type { shift->{type} }

sub _predecessor {
	my ($self, $val) = @_;

	return unless $self && $self->next;
	if ($self->next->item eq $val) {
		return $self;
	}
	else {
		return $self->next->_predecessor($val);
	}
}

1;