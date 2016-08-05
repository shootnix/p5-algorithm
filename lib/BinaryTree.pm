use strict;
use warnings;
use 5.010;


package BinaryTree;

sub new {
	my ($class, $list) = @_;

	return build_tree($list);
}

sub build_tree {
	my ($list) = @_;

	my $root = BinaryTree::Node->new(shift @$list);
	my $node;
	for my $value (@$list) {
		if ($node) {
			$node = $node->add_child($value);
		}
		else {
			$node = $root->add_child($value);
		}
	}

	return $root;
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

sub add_child {
	my ($self, $value) = @_;

	my $child = BinaryTree::Node->new($value);
	if ($self->item > $value) { $self->left($child) }
	else { $self->right($child) }

	return $child;
}

sub item { shift->{item} }

1;