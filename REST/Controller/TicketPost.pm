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


sub Get {
		my $self = shift;
		my @path = qw(Tickets TicketPost);
		my $response;
		my $response_href;
		my @response=();
		
		if (@_ == 1 || @_ == 2){
			push (@path,@_);
		}
		
		else {
			warn ("Wrong number of arguments in TicketPost Controller!\n");
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
			$response_href = XMLin ($response);
			
			
			foreach my $key (keys (%{$response_href->{'post'}})){
				
				$response_href->{'post'}->{$key}->{'id'} = $key;
				
				push (@response,  Kayako::Class::TicketPost->new($response_href->{'post'}->{$key}));
					print $#response;
					
						}
			return @response;	
				}
		else {
			return $response;
				}
					
	}

sub GetAll {
		my $self = shift;
		my @path = qw(Tickets TicketPost ListAll);
		my $response;
		my $response_href;
		my @response=();
		
		if (@_ == 1 ){
			push (@path,@_);
		}
		
		else {
			warn ("Wrong number of arguments in TicketPost Controller!\n");
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
			$response_href = XMLin ($response);
			
		
				foreach my $key (keys (%{$response_href->{'post'}})){
				
				if (ref $response_href->{'post'}->{$key} eq 'HASH'){				
					$response_href->{'post'}->{$key}->{'id'} = $key;
					push (@response,  Kayako::Class::TicketPost->new($response_href->{'post'}->{$key}));
						}
				else {
					push (@response,  Kayako::Class::TicketPost->new($response_href->{'post'}));
						
					}
						
			}
			
			
			
			
			return @response;	
				}
		else {
			return $response;
				}
					
	}
sub Add {
		
		my $self = shift;
		my @path = qw(Tickets TicketPost);
		my $form_ref;
		my $response_href;
		my $response;
		my @tickets;
		my @required = qw(ticketid contents);
		
		
		if (@_){
			
			$form_ref = shift;
			
			}
		else {
			warn ("Post in TicketPost Controller requires a hashref as its arguments");
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
	
sub Delete {
		my $self = shift;
		my @path = qw(Tickets TicketPost);
		my $response;
		my $response_href;
		my @response=();
		
		if (@_ == 2){
			push (@path,@_);
		}
		
		else {
			warn ("Wrong number of arguments in TicketPost Controller!\n");
			return undef;
		}
								
		$response = $self->SUPER::Delete(@path);
		if ($response->is_success){
			$response = $response->decoded_content;
			}
		else {
			warn $response ->status_line;
                        warn $response->decoded_content;
			return undef;
			}
			
				
			return $response;
		
					
	}	
	
1;	