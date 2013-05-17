package Kayako::Class::TicketPost;
use strict;
use warnings;
use Class::Accessor "antlers";
 
has id => ( is => 'ro');
has ticketid => ( is => 'ro');
has dateline => ( is => 'ro');
has userid => ( is => 'ro');
has fullname => ( is => 'ro');
has email => ( is => 'ro');
has emailto => ( is => 'ro');
has ipaddress => ( is => 'ro');
has hasattachments => ( is => 'ro');
has creator => ( is => 'ro');
has isthirdparty => ( is => 'ro');
has ishtml => ( is => 'ro');
has isemailed => ( is => 'ro');
has staffid => ( is => 'ro');
has issurveycomment => ( is => 'ro');
has contents => ( is => 'rw');
has isprivate => ( is => 'ro');
        
1;