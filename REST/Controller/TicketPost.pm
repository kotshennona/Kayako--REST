package Kayako::REST::Controller::TicketPost;
use strict;
use warnings;
use Kayako::Class::TicketPost;
use XML::Simple;

BEGIN {
use parent 'Kayako::REST::Controller';

$Kayako::REST::Controller::TicketPost::VERSION = '0.20';
}

sub new {
	my $class = shift;
	my $self;
	my $error;
	
	if (@_) {
		$self = shift;
			
		$error = "Constructor takes a HASH refrence as an argument\n" unless 
				ref($self) eq 'HASH';
		$error = "Reference to a User Agent is not provided!\n" unless ( $self->{'user_agent'});
	#	$error = "URL seems to be invalid\n" unless 
				$self->{'url'} =~ m!^https?\:{1}\/{2}(a-z0-9\.)*\/api\/index\.php\?e?=?!;

		}
	else {
		die ("Argument is obligatory and must be a hashref.");
		}		
			
	if ($error)
		{
		warn ($error);
		return undef;
		}
	else
		{
		bless ($self,$class);
		return $self;
		}
	}
	
	
1;	