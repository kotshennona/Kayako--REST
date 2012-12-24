package Kayako::Class::CustomFieldOption;
use strict;
use warnings;
use Class::Accessor "antlers";

has customfieldoptionid => ( is =>'ro');
has customfieldid => ( is =>'ro');
has optionvalue => ( is =>'ro');
has displayorder => ( is =>'ro');
has isselected => ( is =>'ro');
has parentcustomfieldoptionid => ( is =>'ro');

1;
