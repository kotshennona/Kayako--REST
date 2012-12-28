package Kayako::REST::Client;
use strict;
use warnings;
use LWP::UserAgent;
use Kayako::REST::Controller::Ticket;
use Kayako::REST::Controller::TicketNote;
use Kayako::REST::Controller::TicketPost;
use Kayako::REST::Controller::TicketType;
use Kayako::REST::Controller::CustomField;
use Kayako::REST::Controller::TicketCustomField;
use Kayako::REST::Controller::Department;

$Kayako::REST::Client::VERSION = "0.09";

sub new {
	my $class = shift;
	my $self = shift;
						
	$self->{'verify_hostname'} = 0;
	$self->{'user_agent'} = new LWP::UserAgent (ssl_opts =>  { verify_hostname => 0 });
		
	bless ($self,$class);
	
	return $self;
	}

sub ApiKey () {
            	   my $self = shift; 
            	   if (@_) {
            	   	   $self->{'api_key'} = shift;
            	   	  
            	   	}
            	   	else {
            	   return $self->{'api_key'};
            	   	}
            }
            
sub SecretKey () {
            	   my $self = shift; 
            	    if (@_) {
            	   	   $self->{'secret_key'} = shift;
            	   	  
            	   	}
            	   	else {
            	   return $self->{'secret_key'};
            	   	}
            	  
            }
            
sub Url () {
            	   my $self = shift; 
            	   if (@_) {
            	   	   $self->{'url'} = shift;
            	   	  
            	   	}
            	   	else {
            	   return $self->{'url'};
            	   	}
            	
            }

sub UserAgent () {
            	   my $self = shift; 
            	   if (@_) {
            	   	   $self->{'user_agent'} = shift;
            	   	  
            	   	}
            	   	else {
            	   return $self->{'user_agent'};
            	   	}
            	
            }           

sub VerifyHostname () {
            	   my $self = shift; 
            	   if (@_) {
            	   	   $self->{'verify_hostname'} = shift;
            	   	  
            	   	}
            	   	else {
            	   return $self->{'verify_hostname'};
            	   	}
            	
            }
            
sub _NewController {
            	  my ($self,$controller) = @_;
            	  my $error;	
		
				if ($error) {
					warn $error;
					return undef;
				}
				else {
					return $controller->new($self->GetAsHashref());
				}
            }

sub GetAsHashref {
	my $self = shift;
	my $hashref = {};
	my @keys = keys(%$self);
	foreach my $key (@keys){
		$hashref->{$key} = $self->{$key};
		}
	
		return $hashref;

	}


sub Department {
            	    my $self = shift;
            	    return _NewController ($self,'Kayako::REST::Controller::Department');
            }    	
            
sub Ticket {
            	    my $self = shift;
            	    return _NewController ($self,'Kayako::REST::Controller::Ticket');
            }
sub TicketNote {
            	    my $self = shift;
            	    return _NewController ($self,'Kayako::REST::Controller::TicketNote');
            }
sub TicketPost {
            	    my $self = shift;
            	    return _NewController ($self,'Kayako::REST::Controller::TicketPost');
            }   

sub TicketType {
            	    my $self = shift;
            	    return _NewController ($self,'Kayako::REST::Controller::TicketType');
            }             

sub CustomField {
            	    my $self = shift;
            	    return _NewController ($self,'Kayako::REST::Controller::CustomField');
            }     

sub TicketCustomField {
            	    my $self = shift;
            	    return _NewController ($self,'Kayako::REST::Controller::TicketCustomField');
            }                
1;