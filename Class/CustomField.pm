package Kayako::Class::CustomField;
use strict;
use warnings;
use Class::Accessor "antlers";

has id => (is => 'ro');
has customfieldgroupid => (is => 'ro');
has title => (is => 'ro');
has fieldtype => (is => 'ro');
has fieldname => (is => 'ro');
has defaultvalue => (is => 'ro');
has srequired => (is => 'ro');
has usereditable => (is => 'ro');
has staffeditable => (is => 'ro');
has regexpvalidate => (is => 'ro');
has displayorder => (is => 'ro');
has encryptindb => (is => 'ro');
has description => (is => 'ro');

1;