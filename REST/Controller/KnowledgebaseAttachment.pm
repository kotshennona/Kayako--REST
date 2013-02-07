package Kayako::REST::Controller::KnowledgebaseAttachment;
use strict;
use warnings;
use Kayako::Class::KnowledgebaseAttachment;
use XML::Simple;

BEGIN {
use parent 'Kayako::REST::Controller';

$Kayako::REST::Controller::KnowledgebaseAttachment::VERSION = '0.10';
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
		my @path = qw(Knowledgebase Attachment);
		my $response;
		my $response_href;
		my @KnowledgebaseAttachments;
		
		if ($_[0]){
			push @path, $_[0];
			}
		else {
			warn ("Missing argument to Get in KnowledgebaseAttachment\n");
       return undef;
			}
		if ($_[1]) {
			push @path, $_[0];
			}
		else {
			warn ("Missing argument to Get in KnowledgebaseAttachment\n");
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
			$response_href = XMLin ($response, KeyAttr=>{KnowledgebaseAttachment => 'id' });			
			$response_href = $response_href->{'kbattachment'};
			
				push (@KnowledgebaseAttachments, Kayako::Class::KnowledgebaseAttachment->new($response_href));
					return @KnowledgebaseAttachments;
						
					}
		else {
			return $response;
				}
					
	}
	
	sub GetAll {
		my $self = shift;
		my @path = qw(Knowledgebase Attachment ListAll);
		if ($_[0]){
			push @path, $_[0];
			}
		else {
			warn ("Missing argument to GetAll in KnowledgebaseAttachment\n");
       return undef;
			}
		my $response;
		my $response_href;
		my @response=();
		
								
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
			$response_href = XMLin ($response);
			
			
			foreach my $key (keys (%{$response_href->{'kbattachment'}})){
				
				$response_href->{'kbattachment'}->{$key}->{'id'} = $key;
				
				push (@response,  Kayako::Class::KnowledgebaseAttachment->new($response_href->{'kbattachment'}->{$key}));
					print $#response;
					
						}
			return @response;	
				}
		else {
			return $response;
				}
					
	}


sub Add {
		my $self = shift;
		my @path = qw(Knowledgebase Attachment);
		my $form_ref;
		my @required_field = qw/bkarticleid filename contents/;
		
		if ($_[0]){
			$form_ref =  $_[0];
			}
		else {
			warn ("Missing argument to Add in KnowledgebaseAttachment\n");
       return undef;
			}
		my $response;
		my $response_href;
		my @response=();
		
		if (ref $form_ref ne 'HASH'){
			warn ("method Add takes a hashref as argument");
			return undef;
			}
			
		foreach my $field (@required_fields) {
			unless (defined $form_ref->{$field}){
				warn "Missing $field in the submitted form.";
				return undef;
			}
		}
								
		$response = $self->SUPER::Post(@path,$form_ref);
		if ($response->is_success){
			$response = $response->decoded_content;
			}
		else {
			warn $response ->status_line;
warn $response->decoded_content;
			return undef;
			}
			
				
		if (wantarray){
			$response_href = XMLin ($response);
			
			
			foreach my $key (keys (%{$response_href->{'kbattachment'}})){
				
				$response_href->{'kbattachment'}->{$key}->{'id'} = $key;
				
				push (@response,  Kayako::Class::KnowledgebaseAttachment->new($response_href->{'kbattachment'}->{$key}));
					print $#response;
					
						}
			return @response;	
				}
		else {
			return $response;
				}
					
	}

sub Delete {
		my $self = shift;
		my @path = qw(Knowledgebase Attachment);
				
		if ($_[0] && $_[1]){
			push (@path, $_[0], $_[1]);
					}
		else {
			warn ("Missing argument to Add in KnowledgebaseAttachment\n");
       return undef;
			}
		my $response;
										
		$response = $self->SUPER::Delete(@path);
		if ($response->is_success){
			return 1;
			}
		else {
			warn $response ->status_line;
warn $response->decoded_content;
			return undef;
			}
					
										
	}
1;
