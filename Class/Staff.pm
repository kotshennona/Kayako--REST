package Kayako::Class::Staff;
use strict;
use warnings;
use Class::Accessor "antlers";

has id => ( is => 'ro');
has staffgroupid => ( is => 'ro');
has firstname => ( is => 'ro');
has lastname => ( is => 'ro');
has fullname => ( is => 'ro');
has username => ( is => 'ro');
has email => ( is => 'ro');
has designation => ( is => 'ro');
has greeting => ( is => 'ro');
has mobilenumber => ( is => 'ro');
has isenabled => ( is => 'ro');
has timezone => ( is => 'ro');
has enabledst => ( is => 'ro');
has signature => ( is => 'ro');

sub staffid {
 	my $self = shift;
 	return $self->{'id'};
 }
 
1;