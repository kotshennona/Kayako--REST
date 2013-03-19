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
				
				push (@response,  Kayako::Class::Department->new($response_href->{'post'}->{$key}));
					print $#response;
					
						}
			return @response;	
				}
		else {
			return $response;
				}
					
	}
	
	
1;	