package Kayako::Class::CustomFieldValue;
use strict;
use warnings;
use Class::Accessor "antlers";

has id => ( is =>'ro');
has groupid => ( is =>'ro');
has grouptitle => ( is =>'ro');
has type => ( is =>'ro');
has name => ( is =>'ro');
has title => ( is =>'ro');
has contents => ( is =>'ro');

1;
