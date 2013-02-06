package Kayako::REST::Controller::TicketCustomField;
use strict;
use warnings;
use Kayako::Class::CustomFieldValue;
use XML::Simple;

our %CustomFieldTypes = (
'Text' =>	1,
'Text area' =>	2,
Password =>	3,
Checkbox =>	4,
Radio =>	5,
Select =>	6,
'Multi select' =>	7,
Custom =>	8,
'Linked select fields' =>	9,
Date =>	10,
File =>	11 
);


BEGIN {
use parent 'Kayako::REST::Controller';

$Kayako::REST::Controller::TicketCustomField::VERSION = '0.20';
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



sub Add {
        my $self = shift;
        my @path = qw(Tickets TicketCustomField);
        my $form_ref;
        my $response;
        
        
        if (@_){
			 
        		push (@path,shift);
		}
	else {
			warn ("Missing argument to Get in Ticket Controller!\n");
			return undef;
		}
	if (@_){
			$form_ref = shift;
		}
	else {
			warn ("Missing argument to Get in Ticket Controller!\n");
			return undef;
		}
		
	
         
         if ( ref $form_ref ne 'HASH'){
                 warn ("Second argument has to be a hashref!\n");
			return undef;
                }
        
                $response = $self->SUPER::Post(@path,$form_ref);

		if ($response->is_success){
			$response = $response->decoded_content;
			}
		else {
			warn $response ->status_line;
			return undef;
			}                
			return $response;
                  }

sub Get {
		my $self = shift;
		my @path = qw(Tickets TicketCustomField);
		my $response;
		my $response_href;
		my @groups;
                my @fields;
		
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
			warn $response->status_line;
			return undef;
			}
			
				
		if (wantarray){
			$response_href = XMLin ($response);
			
			
			foreach my $key (keys (%{$response_href->{'group'}})){
			
				$response_href->{'group'}->{$key}->{'id'} = $key;
				
				push (@groups,  $response_href->{'group'}->{$key});
                                    
					}

					my $hash;
                        foreach my $group (@groups){
				foreach my $key (keys (%{$group->{'field'}})) {
				
				if (ref ($group->{'field'}->{$key}) eq 'HASH'){
                                          
						$group->{'field'}->{$key}->{'name'} = $key;
						$group->{'field'}->{$key}->{'groupid'} = $group->{'id'};
						$group->{'field'}->{$key}->{'grouptitle'} = $group->{'title'};
							

                              push (@fields, 	Kayako::Class::CustomFieldValue->new($group->{'field'}->{$key}));

							}
						}
                                        }


			return @fields;	
						
					}
		else {
			return $response;
				}
					
	}

1;
