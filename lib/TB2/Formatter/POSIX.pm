package TB2::Formatter::POSIX;

use TB2::Mouse;
extends 'TB2::Formatter';

our $VERSION = '1.005000_005';
$VERSION = eval $VERSION;    ## no critic (BuiltinFunctions::ProhibitStringyEval)

sub handle_test_start {
    my $self  = shift;
    my $event = shift;

    $self->write(out => "Running $0\n");

    return;
}

# Map Result types to POSIX types
my %type_map = (
    pass        => "PASS",
    fail        => "FAIL",
    todo_pass   => 'XPASS',
    todo_fail   => 'XFAIL',
    skip_pass   => 'UNTESTED',
    todo_skip   => 'UNTESTED',
);

sub handle_result {
    my($self, $result) = @_;

    my $type = $type_map{$result->type};
    my $name = $result->name;
    my $out = $type;
    $out .= ": $name" if defined $name;

    $self->write(out => "$out\n");

    return;
}

1;
