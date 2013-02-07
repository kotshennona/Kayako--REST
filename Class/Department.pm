package Kayako::Class::Department;
use strict;
use warnings;
use Class::Accessor "antlers";


has id => ( is => 'ro');
has title => ( is => 'ro');
has type => ( is => 'ro');
has app => ( is => 'ro');
has displayorder => ( is => 'ro');
has parentdepartmentid => ( is => 'ro');
has uservisibilitycustom => ( is => 'ro');
#has usergroups => ( is => 'ro');

sub usergroups {
	my $self = shift;
	my @usergroups =();
	
	if (!$self->{'usergroups'}){
		return undef;
			}
	elsif (ref $self->{'usergroups'} eq 'HASH' ){
		push (@usergroups,$self->{'id'});
		}
	elsif (ref $self->{'usergroups'} eq 'ARRAY' ){
		foreach my $ele (@{$self->{'usergroups'}}){
			push (@usergroups,$ele->{'id'});
			}
		}	
		
	if (wantarray) {
		return @usergroups;
			}
	else {
		my $count = @usergroups;
		return $count;
		
		}
}

1;