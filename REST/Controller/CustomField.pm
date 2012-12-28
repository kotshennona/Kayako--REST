package Kayako::REST::Controller::CustomField;
use strict;
use warnings;
use Kayako::Class::CustomField;
use Kayako::Class::CustomFieldOption;
use XML::Simple;

BEGIN {
use parent 'Kayako::REST::Controller';

$Kayako::REST::Controller::CustomField::VERSION = '0.10';
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


sub GetOptions {
		my $self = shift;
		my @path = qw(Base CustomField ListOptions);
		my $response;
		my $response_href;
		my @options;

                if (@_){
			push (@path,shift);
		}
		else {
			warn ("Missing argument to Get in CustomField Controller!\n");
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
			$response_href = XMLin ($response );			
			                                 
                               foreach my $option (@{$response_href->{'option'}}){
                                print $option;
				push (@options, Kayako::Class::CustomFieldOption->new($option));
					
                                        	}
                                    return @options;	
					}
		else {
			return $response;
				}
					
	}


sub GetCustomFields {
		my $self = shift;
		my @path = qw(Base CustomField);
		my $response;
		my $response_href;
		my @customfields;
		
		
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
			$response_href = XMLin ($response );			
			                                 
                               foreach my $customfield (@{$response_href->{'customfield'}}){
				push (@customfields, Kayako::Class::CustomField->new($customfield));
					
                                        	}
                                    return @customfields;	
					}
		else {
			return $response;
				}
					
	}



1;	