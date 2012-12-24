package Kayako::REST::Controller::TicketType;
use strict;
use warnings;
use Kayako::Class::TicketType;
use XML::Simple;

BEGIN {
use parent 'Kayako::REST::Controller';

$Kayako::REST::Controller::TicketType::VERSION = '0.10';
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
	
			
	sub Get {
		my $self = shift;
		my @path = qw(Tickets TicketType);
		my $response;
		my $response_href;
		my @TicketTypes;
		
		if (@_){
			push (@path,shift);
		}
		else {
			warn ("Missing argument to Get in Ticket Controller!\n");
			return undef;
		}
		
		$response = $self->SUPER::Get(@path);
		if ($response->is_success){
			$response = $response->decoded_content;
			}
		else {
			warn $response ->status_line;
                        warn $response->decoded_content;
			return undef;
			}
			
				
		if (wantarray){
			$response_href = XMLin ($response, KeyAttr=>{tickettype => 'id' });			
			$response_href = $response_href->{'tickettype'};
			
				$response_href->{'tickettypeid'}=$response_href->{'id'};
				push (@TicketTypes, Kayako::Class::Ticket->new($response_href));
					return @TicketTypes;
						
					}
		else {
			return $response;
				}
					
	}
	
	sub GetAll {
		my $self = shift;
		my @path = qw(Tickets TicketType);
		my $response;
		my $response_href;
		my @TicketTypes;
		
								
		$response = $self->SUPER::Get(@path);
		if ($response->is_success){
			$response = $response->decoded_content;
			}
		else {
			warn $response ->status_line;
                        warn $response->decoded_content;
			return undef;
			}
			
				
		if (wantarray){
			$response_href = XMLin ($response, KeyAttr=>{tickettype => 'id' });			
			$response_href = $response_href->{'tickettype'};
			foreach my $key (%$response_href){
				$response_href->{$key}->{'tickettypeid'}=$key;
				push (@TicketTypes, Kayako::Class::TicketType->new($response_href->{$key}));
					return @TicketTypes;
						}
					}
		else {
			return $response;
				}
					
	}

1;
