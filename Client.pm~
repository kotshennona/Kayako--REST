package Kayako::Client;
use strict;
use warnings;
use Digest::SHA qw(hmac_sha256);
use APR::Base64;
use URL::Encode;
use LWP::UserAgent;

our $ua; 

sub new {
	#my $class = shift;
	my $self = {};
	$$self{'api_key'} = 'fbf0cf3b-f56d-67e4-bda8-cf45b69d3a3b';
	$$self{'secret_key'} = 'ZWFiNjBiYjUtMjI5ZC0xZmI0LTkxZjctNjI3OGVjZWIyNWQ1YWVmYjlkYzYtOTUxMC0zNGM0LTNkOTgtMDc4NjMyN2Q5OTU1';
	$$self{'url'} = 'https://support.mfisoft.ru/api/index.php?e=';
	my $error;
	
	if ($error)
		{
		return $error;
		}
	else
		{
		bless ($self);
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

        sub GetUri {
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
           
            sub AddTokens ($$) {
            	my $self = shift;
            	my $form = shift;
            	my $salt=`cat /dev/urandom | head -c20 | md5 | head -c10 `;
		my $signature;
		
		$signature = Digest::SHA::hmac_sha256($salt,$self->{'secret_key'});
                $signature = APR::Base64::encode($signature);
             
            	#ref($form) eq 'HASH' or die (AddToken takes a hashref as an argument.);
            	$form->{'apikey'} =  $self->{'api_key'};
            	$form->{'salt'} =  $salt;
            	$form->{'signature'} =  $signature;
            }
        
	#########################################################################      
        #                                                                       #
        #               Methods from Department Controller.                     #
        #                                                                       #
        #########################################################################
	sub GetAllDepartments {
		
		my $self = shift;
		my $uri = GetUri($self,'Base','Department');
		my $response = $ua->get($uri);
		
		return $response;
	}
	sub GetDepartment ($){
		my $self = shift;
		my $id = shift;
		my $uri = GetUri($self,'Base','Department',$id);
		my $response = $ua->get($uri);
		
		
		return $response;
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
                
                $uri = GetUri($self,'Tickets','Ticket','ListAll',$args->{'departmentid'},$args->{'ticketstatusid'},$args->{'ownerid'},$args->{'userid'});
		$response = $ua->get($uri);
                return $response;
            }

        #########################################################################      
        #                                                                       #
        #               Methods from Ticket Post Controller.                    #
        #                                                                       #
        #########################################################################

        sub GetAllTicketPosts ($) {
            my $self = shift;
            my $id = shift;
   
            my $uri = GetUri($self,'Tickets','TicketPost','ListAll',$id);
          
            return $ua->get($uri);
            }

        sub AddTicketPost ($$) {
            my $self = shift;
            my $contents_ref = shift;
            my $uri = GetUri($self,'Tickets','TicketPost');
            
            AddTokens($self, $contents_ref);
            $contents_ref->{'contents'} = URL::Encode::url_encode_utf8($contents_ref->{'contents'} );
            return $ua->post($uri,$contents_ref);
            }
        #########################################################################      
        #                                                                       #
        #               Methods from Ticket Note Controller.                    #
        #                                                                       #
        #########################################################################
        sub GetAllTicketNotes ($) {
            my $self = shift;
            my $id = shift;
   
            my $uri = GetUri($self,'Tickets','TicketPost','ListAll',$id);
          
            return $ua->get($uri);
            }
        sub GetTicketNote ($$) {
            my $self = shift;
            my $id = shift;
            my $noteid = shift;
   
            my $uri = GetUri($self,'Tickets','TicketPost','ListAll',$id,$noteid);
          
            return $ua->get($uri);
            }
        sub AddTicketNote ($$) {
            my $self = shift;
            my $contents_ref = shift;
            my $uri = GetUri($self,'Tickets','TicketNote');
            
            AddTokens($self, $contents_ref);
           # $contents_ref->{'contents'} = URL::Encode::url_encode_utf8($contents_ref->{'contents'} );
            return $ua->post($uri,$contents_ref);
            }
        sub DeleteTicketNote ($$) {
            my $self = shift;
            my $id = shift;
            my $noteid = shift;
   
            my $uri = GetUri($self,'Tickets','TicketPost','ListAll',$id,$noteid);
          
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
            my $uri = GetUri($self,'Tickets','TicketCustomField',$id);
             
            $response =  $ua->get($uri);
            return $response;
            }

         sub AddCustomField ($$) {
            my $self = shift;
            my $id = shift;
            my $form_ref = shift;
            my $uri = GetUri($self,'Tickets','TicketCustomField',$id);
            $form_ref->{'dlyixo0n794z'} = URL::Encode::url_encode_utf8($form_ref->{'dlyixo0n794z'} );
               AddTokens($self, $form_ref);
            return $ua->post($uri,$form_ref);
            }

        #########################################################################      
        #                                                                       #
        #                        Methods from TEST Controller.                  #
        #                                                                       #
        #########################################################################

        sub TestPost {
            my $self = shift;
            my $uri = GetUri($self,'Core','Test');
            my $form_ref = {};
            AddTokens($self, $form_ref);
            return $ua->post($uri,$form_ref);
        }

1;
