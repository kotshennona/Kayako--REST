package Kayako::REST::Controller;
use strict;
use warnings;
use Digest::SHA qw(hmac_sha256);
use APR::Base64;
use URL::Encode;


BEGIN {
$Kayako::REST::Controller::VERSION = "0.29";
}
	#########################################################################      
        #                                                                       #
        #                           Constructor                                 #
        #                                                                       #
        #########################################################################

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

        #########################################################################      
        #                                                                       #
        #                            General methods                            #
        #                                                                       #
        #########################################################################
	
		

        sub GetUri {
		my $self = shift;
		my @parts = @_;
		my $uri = '';
		my $query;
		my $salt=`cat /dev/urandom | head -c20 | md5 | head -c10 `;
		my $signature;
		foreach my $element (@parts) {
			$query .= '/'.$element if defined($element);
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
            
      	
     
	#########################################################################      
        #                                                                       #
        #               Methods from Department Controller.                     #
        #                                                                       #
        #########################################################################
	sub Get {
		
		my $self = shift;
		my @path = @_;
		my $uri = GetUri($self,@path);
				
		return  $self->{'user_agent'}->get($uri);
	}
	
	sub Put {
		my $self = shift;
		my @path = @_;
		my $form_ref = pop(@path);
		
		my $uri = GetUri($self,@path);
		
		if (ref($form_ref) ne 'HASH'){
            		warn "Last argument to the UpdateDepartment must be a HASH reference";
            		return 0;
            		}
		
		
		_AddTokens ($self,$form_ref);
		_ToQueryString ($form_ref,'usergroupid[]');
				
		return $self->{'user_agent'}->put($uri,$form_ref);
		
	}
	
	sub Post {
		my $self = shift;
		my @path = @_;
		my $form_ref = pop(@path);
		
		my $uri = GetUri($self,@path);
		
		if (ref($form_ref) ne 'HASH'){
            		warn "UpdateDepartment takes a hash reference as an argument\n";
            		return 0;
            		}
						
		_AddTokens ($self,$form_ref);
		#_ToQueryString ($form_ref,'usergroupid[]');
		
		
		return $self->{'user_agent'}->post($uri,$form_ref);
		
	}	
	
	sub Delete {
		
		my $self = shift;
		my @path = @_;
		my $uri = GetUri($self,@path);
				
		return  $self->{'user_agent'}->delete($uri);
	}
	
1;