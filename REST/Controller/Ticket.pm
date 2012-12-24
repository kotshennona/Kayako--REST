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
	
	
	sub Create {
		
		my $self = shift;
		my @path = qw(Tickets Ticket);
		my $form_ref;
		my $response_href;
		my $response;
		my @tickets;
		my @required = qw(subject fullname email contents departmentid ticketstatusid ticketpriorityid tickettypeid);
		
		
		if (@_){
			
			$form_ref = shift;
			
			}
		else {
			warn ("Post in Tickets Controller requires a hashref as its arguments");
			return undef;
			}
		
		foreach my $field (@required) {
			unless ($form_ref->{$field}){
				warn ("$field is required!\n");
				return undef;
				}

			unless ($form_ref->{'autouserid'} || $form_ref->{'userid'} || $form_ref->{'staffid'} ){
				warn ("You must provide one of the following options: autouserid, userid or staffid!");
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
			$response_href = XMLin ($response, KeyAttr=>{ticket => 'id' });			
			$response_href = $response_href->{'ticket'};
			
			$response_href->{'ticketid'}=$response_href->{'id'};
			push (@tickets, Kayako::Class::Ticket->new($response_href));
				return @tickets;
						
					}
		else {
			return $response;
				}
	
		}
	}
	sub Update {
		my $self = shift;
		my @path = qw(Tickets Ticket);
		my %editable_fields;
		my @editable_fields = qw(subject fullname email departmentid ticketstatusid ticketpriorityid tickettypeid ownerstaffid userid templategroup);
		my $form_ref;
		my $response_href;
		my $response;
		my @tickets;
		
		if (@_){
			push (@path,shift);
			$form_ref = shift;
			
			}
		else {
			warn ("Update in Tickets Controller requires a ticketid and a hashref as its arguments");
			return undef;
			}
		foreach  my $field (@editable_fields){
			$editable_fields{$field} = 1;
			}
		foreach my $key (%$form_ref){
			delete $form_ref->{$key} unless $editable_fields{$key};
			}
		
			$response = $self->SUPER::Put(@path,$form_ref);
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
			
			$response_href->{'ticketid'}=$response_href->{'id'};
			push (@tickets, Kayako::Class::Ticket->new($response_href));
				return @tickets;
						
					}
		else {
			return $response;
				}
		}
		
	sub Get {
		my $self = shift;
		my @path = qw(Tickets Ticket);
		my $response;
		my $response_href;
		my @tickets;
		
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
			return undef;
			}
			
				
		if (wantarray){
			$response_href = XMLin ($response, KeyAttr=>{ticket => 'id' });			
			$response_href = $response_href->{'ticket'};
			
				$response_href->{'ticketid'}=$response_href->{'id'};
				push (@tickets, Kayako::Class::Ticket->new($response_href));
					return @tickets;
						
					}
		else {
			return $response;
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
