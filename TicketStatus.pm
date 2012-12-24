package Kayako::Class::TicketStatus;
use strict;
use warnings;
use Class::Accessor "antlers";

has ticketstatusid => ( is => 'ro');
has  title => ( is => 'ro');
has  displayorder => ( is => 'ro');
has  departmentid => ( is => 'ro');
has  displayicon => ( is => 'ro');
has  type => ( is => 'ro');
has  displayinmainlist => ( is => 'ro');
has  markasresolved => ( is => 'ro');
has  displaycount => ( is => 'ro');
has  statuscolor => ( is => 'ro');
has  statusbgcolor => ( is => 'ro');
has  resetduetime => ( is => 'ro');
has  triggersurvey => ( is => 'ro');
has  staffvisibilitycustom => ( is => 'ro');

1;