package Kayako::Client;
use strict;
use warnings;
use Digest::SHA qw(hmac_sha256);
use APR::Base64;
use URL::Encode;
use LWP::UserAgent;

our $ua; 
our $VERSION = "0.26";
	#########################################################################      
        #                                                                       #
        #                           Constructor                                 #
        #                                                                       #
        #########################################################################

sub new {
	my $class = shift;
	my $self = shift;
	my $error;
	
	if (ref($self) ne 'HASH'){
		$error = "Constructor takes a HASH refrence as an argument\n";
		}
	if (!defined($self->{'api_key'}) || $self->{'api_key'} eq ''){
		$error = "API key is not provided\n";
		}
	if (!defined($self->{'secret_key'}) || $self->{'secret_key'} eq ''){
		$error = "Secret key is not provided\n";
		}
	if (!defined($self->{'url'}) || $self->{'url'} eq ''){
		$error = "URL to your helpdesk is not provided\n";
		}
	if (!$self->{'url'} =~m!^https?\:{1}\/{2}(a-z0-9\.)*\/api\/index\.php\?e?=?!){
		$error = "URL seems to be invalid\n";
		}
		
	if ($error)
		{
		die ($error);
		}
	else
		{
		bless ($self,$class);
	return $self;
		}
	}

        #########################################################################      
        #                                                                       #
        #                            General methods                            #
        #                                                                       #
        #########################################################################
	sub Connect {
		$ua = LWP::UserAgent->new;
		$ua -> ssl_opts (verify_hostname => 0);
		}

        sub _GetUri {
		my $self = shift;
		my @parts = @_;
		my $uri = '';
		my $query;
		my $salt=`cat /dev/urandom | head -c20 | md5 | head -c10 `;
		my $signature;
		foreach my $element (@parts) {
			$query .= '/'.$element;
			}
		$signature = Digest::SHA::hmac_sha256($salt,$self->{'secret_key'});
                $signature = APR::Base64::encode($signature);
                $signature = URL::Encode::url_encode($signature);
                               
		 return $self->{'url'}.$query.'&apikey='.$self->{'api_key'}.'&salt='.$salt.'&signature='.$signature;
		
			}	
           
            sub _AddTokens ($$) {
            	my $self = shift;
            	my $form = shift;
            	my $salt=`cat /dev/urandom | head -c20 | md5 | head -c10 `;
		my $signature;
		
		$signature = Digest::SHA::hmac_sha256($salt,$self->{'secret_key'});
                $signature = APR::Base64::encode($signature);
             
            	$form->{'apikey'} =  $self->{'api_key'};
            	$form->{'salt'} =  $salt;
            	$form->{'signature'} =  $signature;
            }
            sub _ToQueryString ($@){
            	my $form_ref = shift;
            	my @fields = @_;
            	
            	foreach my $field (@fields){
            		
            		my $temp_line='?';
            		foreach my $value (@{$form_ref->{$field}}){
            			$temp_line .= $field.'='.$value.'&';
            			}
            		$form_ref->{$field}=$temp_line;
            		}
            		
            	return 1;
            	}
            sub Get_api_key () {
            	   my $self = shift; 
            	   
            	   return $self->{'api_key'};
            }
            
            sub Get_secret_key () {
            	   my $self = shift; 
            	   
            	   return $self->{'secret_key'};
            }
            
           sub Get_url () {
            	   my $self = shift; 
            	   
            	   return $self->{'url'};
            }
	#########################################################################      
        #                                                                       #
        #               Methods from Department Controller.                     #
        #                                                                       #
        #########################################################################
	sub GetAllDepartments {
		
		my $self = shift;
		my $uri = _GetUri($self,'Base','Department');
		my $response = $ua->get($uri);
		
		return $response;
	}
	sub GetDepartment ($){
		my $self = shift;
		my $id = shift;
		my $uri = _GetUri($self,'Base','Department',$id);
		my $response = $ua->get($uri);
		
		
		return $response;
	}
	sub UpdateDepartment ($$){
		my $self = shift;
		my $id = shift;
		my $form_ref = shift;
		my $uri = _GetUri($self,'Base','Department',$id);
		
		if (ref($form_ref) ne 'HASH'){
            		warn "UpdateDepartment takes a hash reference as an argument\n";
            		return 0;
            		}
		if (!defined $form_ref->{title} || $form_ref->{title} eq ''){
			warn ("Title argument is empty or absent");
			return 0;
		}
		_AddTokens ($self,$form_ref);
		_ToQueryString ($form_ref,'usergroupid[]');
		
		
		return $ua->post($uri,$form_ref);
		
	}
			
		
	#########################################################################      
        #                                                                       #
        #               Methods from Tickets Controller.                        #
        #                                                                       #
        #########################################################################
	
        sub GetAllTickets {
            my $uri;
            my $response;
            my  $args;
            my $self = shift;
            if (@_) {
                $args   = shift;
                } else {
                $args = {};
                    }
                foreach my $key ('departmentid', 'ticketstatusid','ownerid','userid')    {
                    $args->{$key} = '-1' unless $args->{$key};
                                  }
                
                $uri = _GetUri($self,'Tickets','Ticket','ListAll',$args->{'departmentid'},$args->{'ticketstatusid'},$args->{'ownerid'},$args->{'userid'});
		$response = $ua->get($uri);
                return $response;
            }
        #########################################################################      
        #                                                                       #
        #               Methods from TicketSearch Controller.                   #
        #                                                                       #
        #########################################################################       
            sub SearchTickets ($){
            	my ($uri, $response);
            	my $self = shift;
            	my $form_ref = shift;
            	
            	if (ref($form_ref) ne 'HASH'){
            		warn "Search Tickets takes a has reference as an argument\n";
            		return 0;
            		}
            	if ( !defined $form_ref->{query} ||  $form_ref->{query} eq ''){
            		warn "Query string is empty\n";
            		return 0;
            		}
            		
            	$uri = _GetUri($self,'Tickets','TicketSearch');
		_AddTokens($self, $form_ref);
		 
		return $ua->post($uri,$form_ref);
            	
            }
        #########################################################################      
        #                                                                       #
        #               Methods from TicketCount Controller.                    #
        #                                                                       #
        #########################################################################
           
        	sub GetTicketCount () {
            	    my $self = shift;
            	    my $uri = _GetUri($self,'Tickets','TicketSearch');
             		 
		return $ua->get($uri);
            	
            	}
        #########################################################################      
        #                                                                       #
        #               Methods from Ticket Post Controller.                    #
        #                                                                       #
        #########################################################################

        sub GetAllTicketPosts ($) {
            my $self = shift;
            my $id = shift;
   
            my $uri = _GetUri($self,'Tickets','TicketPost','ListAll',$id);
          
            return $ua->get($uri);
            }

        sub AddTicketPost ($$) {
            my $self = shift;
            my $form_ref = shift;
            my $uri = _GetUri($self,'Tickets','TicketPost');
            
            _AddTokens($self, $form_ref);
            return $ua->post($uri,$form_ref);
            }
        #########################################################################      
        #                                                                       #
        #               Methods from Ticket Note Controller.                    #
        #                                                                       #
        #########################################################################
        sub GetAllTicketNotes ($) {
            my $self = shift;
            my $id = shift;
   
            my $uri = _GetUri($self,'Tickets','TicketPost','ListAll',$id);
          
            return $ua->get($uri);
            }
        sub GetTicketNote ($$) {
            my $self = shift;
            my $id = shift;
            my $noteid = shift;
   
            my $uri = _GetUri($self,'Tickets','TicketPost','ListAll',$id,$noteid);
          
            return $ua->get($uri);
            }
        sub AddTicketNote ($$) {
            my $self = shift;
            my $form_ref = shift;
            my $uri = _GetUri($self,'Tickets','TicketNote');
            
            _AddTokens($self, $form_ref);
            return $ua->post($uri,$form_ref);
            }
        sub DeleteTicketNote ($$) {
            my $self = shift;
            my $id = shift;
            my $noteid = shift;
   
            my $uri = _GetUri($self,'Tickets','TicketPost','ListAll',$id,$noteid);
          
            return $ua->delete($uri);
            }
        #########################################################################      
        #                                                                       #
        #           Methods from TicketCustomField Controller.                  #
        #                                                                       #
        #########################################################################

        sub GetAllCustomFields ($) {
            my $self = shift;
            my $id = shift;
            my $response;
            my $uri = _GetUri($self,'Tickets','TicketCustomField',$id);
             
            $response =  $ua->get($uri);
            return $response;
            }

         sub AddCustomField ($$) {
            my $self = shift;
            my $id = shift;
            my $form_ref = shift;
            my $uri = _GetUri($self,'Tickets','TicketCustomField',$id);
            $form_ref->{'dlyixo0n794z'} = URL::Encode::url_encode_utf8($form_ref->{'dlyixo0n794z'} );
               _AddTokens($self, $form_ref);
            return $ua->post($uri,$form_ref);
            }

        #########################################################################      
        #                                                                       #
        #                        Methods from TEST Controller.                  #
        #                                                                       #
        #########################################################################

        sub TestPost {
            my $self = shift;
            my $uri = _GetUri($self,'Core','Test');
            my $form_ref = {};
            _AddTokens($self, $form_ref);
            return $ua->post($uri,$form_ref);
        }

1;
