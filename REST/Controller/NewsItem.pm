package Kayako::REST::Controller::NewsItem;
use strict;
use warnings;
use Kayako::Class::NewsItem;
use XML::Simple;

BEGIN {
use parent 'Kayako::REST::Controller';

$Kayako::REST::Controller::NewsItem::VERSION = '0.10';
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
	
=head2 GetAll 
Retrieves a News Item, identified by its id.
In scalar context returns server response in XML.
In list context returns an array (containing one Kayako::Class::NewsItem object).
=cut			
		
	sub Get {
		my $self = shift;
		my @path = qw(News NewsItem);
		my $response;
		my $response_href;
		my @NewsItems;
		
		if ($_[0]){
			push @path, $_[0];
			}
		else {
			warn ("Missing argument to Get in NewsItem\n");
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
			$response_href = XMLin ($response, KeyAttr=>{NewsItem => 'id' });			
			$response_href = $response_href->{'NewsItem'};
			
				push (@NewsItems, Kayako::Class::NewsItem->new($response_href));
					return @NewsItems;
						
					}
		else {
			return $response;
				}
					
	}

=head2 GetAll ([categoryid])
Retrieves a list of news items, optionally filtered by category id. This method provides interface to 2 differrent
api methods.
In scalar context returns server response in XML.
In list context returns an array of Kayako::Class::NewsItem objects.
=cut	
	sub GetAll {
		my $self = shift;
		my @path;
		my $response;
		my $response_href;
		my @response=();
		
		if ($_[0]){
			@path = qw(News NewsItem ListAll);
			push @path, $_[0];
			$response = $self->SUPER::Get(@path);
			}
		else {
			@path = qw(News NewsItem );
			$response = $self->SUPER::Get(@path);
			}
								
		
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
			
			
			foreach my $key (keys (%{$response_href->{'newsitem'}})){
				
				$response_href->{'newsitem'}->{$key}->{'id'} = $key;
				
				push (@response,  Kayako::Class::NewsItem->new($response_href->{'newsitem'}->{$key}));
					print $#response;
					
						}
			return @response;	
				}
		else {
			return $response;
				}
					
	}

=head2 Add
Create a new news item. Takes a hash reference as argument.
=head3 POST Arguments 
REQUIRED:
subject 	The news item subject.
contents 	The news item contents.
staffid 	The Staff ID.

OPTIONAL:
newstype 	The news type.  Global: 1, public: 2, private: 3
newsstatus 	The news status. Draft: 1, published: 2.
fromname	The custom from name used in email notification.
email		The custom from email used in email notification.
customemailsubject 	The custom subject used in email notification.
sendemail	Whether to send email notification. 0 or 1.
allowcomments	Allow comments. 0 or 1.
uservisibilitycustom	The user visibility custom. 0 or 1.
usergroupidlist 	The user group ID list. Multiple values comma separated like 1,2,3
staffvisibilitycustom	The staff visibility custom. 0 or 1.
staffgroupidlist 	The staff group id list. Multiple values comma separated like 1,2,3.
expiry	The expiry date in m/d/Y format.
newscategoryidlist 	The category ID list. Multiple values comma separated like 1,2,3. 

=cut

sub Add {
		my $self = shift;
		my @path = qw/News NewsItem/;
		my $form_ref;
		my @required_fields = qw/subject staffid contents/;
		
		if ($_[0]){
			$form_ref =  $_[0];
			}
		else {
			warn ("Missing argument to Add in NewsItem\n");
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
			
			
			foreach my $key (keys (%{$response_href->{'newsitem'}})){
				
				$response_href->{'newsitem'}->{$key}->{'id'} = $key;
				
				push (@response,  Kayako::Class::NewsItem->new($response_href->{'newsitem'}->{$key}));
					print $#response;
					
						}
			return @response;	
				}
		else {
			return $response;
				}
					
	}
	
=head2 Update
Makes a news item unavailable to users;
$client->NewsItem->Update($itemid, \%form);
=cut
	sub Update {
		my $self = shift;
		my @path = qw/News NewsItem/;
		my $form_ref;
		my @required_fields = qw/subject editedstaffid contents/;
		
		if ($_[0]){
			push (@path, $_[0]);
					}
		else {
			warn ("Missing argument to Update in NewsItem\n");
       		return undef;
			}
		if ($_[1]){
			$form_ref =  $_[1];
			}
		else {
			warn ("Missing argument to Update in NewsItem\n");
       return undef;
			}
		my $response;
		my $response_href;
		my @response=();
		
		if (ref $form_ref ne 'HASH'){
			warn ("method Update takes a hashref as its second argument");
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
			
			
			foreach my $key (keys (%{$response_href->{'newsitem'}})){
				
				$response_href->{'newsitem'}->{$key}->{'id'} = $key;
				
				push (@response,  Kayako::Class::NewsItem->new($response_href->{'newsitem'}->{$key}));
					print $#response;
					
						}
			return @response;	
				}
		else {
			return $response;
				}
					
	}
	
=head2 Delete
Makes a news item unavailable to users;
$client->NewsItem->Delete($itemid);
=cut
sub Delete {
		my $self = shift;
		my @path = qw(News NewsItem);
				
		if ($_[0]){
			push (@path, $_[0]);
					}
		else {
			warn ("Missing argument to Delete in NewsItem\n");
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
