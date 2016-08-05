use strict;
use warnings;
use 5.010;


package BinaryTree;


sub new {
	my ($class, $list) = @_;

	my $self = {
		root => BinaryTree::Node->new(shift @$list),
	};
	bless $self, $class;

	for my $value (@$list) {
		$self->add($value);
	}

	return $self->{root};
}

sub add {
	my ($self, $value) = @_;

	my $current = $self->{root};
	while (1) {
		if ($value >= $current->item) {
			if (!$current->right) {
				$current->right(BinaryTree::Node->new($value));
				last;
			}
			else {
				$current = $current->right;
			}
		}
		else {
			# left
			if (!$current->left) {
				$current->left(BinaryTree::Node->new($value));
				last;
			}
			else {
				$current = $current->left;
			}
		}
	}
}



package BinaryTree::Node;


sub new {
	my ($class, $value) = @_;

	my $self = {
		L => undef,
		R => undef,
		item => $value,
	};

	return bless $self, $class;
}

sub left {
	my ($self, $value) = @_;

	if ($value) {
		$self->{L} = $value;
	}

	return $self->{L};
}

sub right {
	my ($self, $value) = @_;

	if ($value) {
		$self->{R} = $value;
	}

	return $self->{R};
}

sub insert {
	my ($self, $value) = @_;

	if ($self->item >= $value) {
		$self->left(insert($self->left, $value));
	}
	else {
		$self->right(insert($self->right, $value));
	}

	return $self;
}

sub item {
	my ($self, $value) = @_;

	if ($value) {
		$self->{item} = $value;
	}

	return $self->{item};
}

sub search {
	my ($self, $value) = @_;

	return 1 if $self->item == $value;
	if ($value < $self->item) {
		return $self->left ? $self->left->search($value) : undef;
	}
	else {
		return $self->right ? $self->right->search($value) : undef;
	}

	return undef;
}

sub min {
	my ($self) = @_;

	my $min = $self;
	while ($min->left) {
		$min = $min->left;
	}

	return $min;
}

sub max {
	my ($self) = @_;

	my $max = $self;
	while ($max->right) {
		$max = $max->right;
	}

	return $max;
}



1;