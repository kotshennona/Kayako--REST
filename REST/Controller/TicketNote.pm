package Kayako::REST::Controller::TicketNote;
use strict;
use warnings;
use Kayako::Class::TicketNote;
use XML::Simple;

BEGIN {
use parent 'Kayako::REST::Controller';

$Kayako::REST::Controller::TicketNote::VERSION = '0.10';
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
	
sub Add {
		
		my $self = shift;
		my @path = qw(Tickets TicketNote);
		my $form_ref;
		my $response_href;
		my $response;
		my @tickets;
		my @required = qw(ticketid contents);
		
		
		if (@_){
			
			$form_ref = shift;
			
			}
		else {
			warn ("Post in TicketNote Controller requires a hashref as its arguments");
			return undef;
			}
		
		foreach my $field (@required) {
			unless ($form_ref->{$field}){
				warn ("$field is required!\n");
				return undef;
				}

			
 
		$response = $self->SUPER::Post(@path,$form_ref);
		
		if ($response->is_success){
			$response = $response->decoded_content;
			}
		else {
			warn $response ->status_line."\n".$response->decoded_content."\n";
			return undef;
			}
	
		if (wantarray){
			$response_href = XMLin ($response, KeyAttr=>{note => 'id' });			
			$response_href = $response_href->{'note'};
			
			push (@tickets, Kayako::Class::TicketNote->new($response_href));
				return @tickets;
						
					}
		else {
			return $response;
				}
	
		}
	}	
1;