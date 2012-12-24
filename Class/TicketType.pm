package Kayako::Class::TicketType;
use strict;
use warnings;
use Class::Accessor "antlers";

tickettypeid => ( is => 'ro');
has title => ( is => 'ro');
has displayorder => ( is => 'ro');
has departmentid => ( is => 'ro');
has displayicon => ( is => 'ro');
has type => ( is => 'ro');
has uservisibilitycustom => ( is => 'ro');


1;