package Kayako::REST::Controller::Department;
use strict;
use warnings;
use Kayako::Class::Department;
use XML::Simple;

BEGIN {
use parent 'Kayako::REST::Controller';

$Kayako::REST::Controller::Department::VERSION = '0.10';
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
		my @path = qw(Base Department);
		my $response;
		my $response_href;
		my @departments;
		
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
			$response_href = XMLin ($response, KeyAttr=>{department => 'id' });			
			$response_href = $response_href->{'department'};
			
				$response_href->{'departmentid'}=$response_href->{'id'};
				push (@departments, Kayako::Class::Ticket->new($response_href));
					return @departments;
						
					}
		else {
			return $response;
				}
					
	}
	
	sub GetAll {
		my $self = shift;
		my @path = qw(Base Department);
		my $response;
		my $response_href;
		my @departments;
		
								
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
			$response_href = XMLin ($response, KeyAttr=>{department => 'id' });			
			$response_href = $response_href->{'department'};
			foreach my $key (%$response_href){
				$response_href->{$key}->{'departmentid'}=$key;
				push (@departments, Kayako::Class::Department->new($response_href->{$key}));
					return @departments;
						}
					}
		else {
			return $response;
				}
					
	}

1;
