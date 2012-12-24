package Kayako::REST::Controller::Ticket;
use strict;
use warnings;
use Kayako::Class::Ticket;
use XML::Simple;

BEGIN {
use parent 'Kayako::REST::Controller';

$Kayako::REST::Controller::Ticket::VERSION = '0.20';
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
	
	sub GetAll {
		my $self = shift;
		my @path = qw(Tickets Ticket ListAll);
		my $form_ref;
		my $response;
		my $response_href;
		my @tickets;
		
		if (@_) {
			$form_ref = shift;
			return undef unless  ref($form_ref) eq 'HASH';
			return undef unless $form_ref ->{'departmentid'};
		}
		foreach my $key ('departmentid','ticketstatusid','ownerstaffid','userid'){
			$form_ref->{$key} = '-1' unless $form_ref->{$key};
			push (@path, $form_ref->{$key});
			}
						
		$response = $self->SUPER::Get(@path);
		if ($response->is_success){
			$response = $response->decoded_content;
			}
		else {
			warn $response ->status_line;
			return undef;
			}
			
				
		if (wantarray){
			$response_href = XMLin ($response, KeyAttr=>{ticket => 'id' });			
			$response_href = $response_href->{'ticket'};
			foreach my $key (%$response_href){
				$response_href->{$key}->{'ticketid'}=$key;
				push (@tickets, Kayako::Class::Ticket->new($response_href->{$key}));
					return @tickets;
						}
					}
		else {
			return $response;
				}
					
	}

1;
