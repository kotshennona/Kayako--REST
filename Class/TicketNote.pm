package Kayako::Class::Ticket;
use strict;
use warnings;
use Class::Accessor "antlers";

has content => ( is => 'rw') ;
has note_type => ( is => 'rw'); 
has id => ( is => 'ro') ;
has ticketid => ( is => 'ro') ;
has notecolor => ( is => 'rw') ;
has creatorstaffid => ( is => 'ro') ;
has forstaffid => ( is => 'ro') ;
has creatorstaffname => ( is => 'ro') ;
has creationdate => ( is => 'ro') ;

1;