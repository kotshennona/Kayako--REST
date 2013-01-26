
use strict;
use warnings;

BEGIN { require 5.008; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Kayako Helpdesk REST API library',
  'AUTHOR' => 'Konstantin Osipov <castorfiber@ya.ru>',
  'DISTNAME' => 'Kayako-Client',
  'LICENSE' => 'perl',
  'NAME' => 'Kayako::Client',
  'PREREQ_PM' => {
    'LWP::UserAgent' => '0',
    'Class::Accessor' => '0',
    'Digest::SHA' => '0',
 	'MIME::Base64::Perl' => '0',
 	'URL::Encode' => '0',
  },
    'VERSION_FROM' => 'REST/Client.pm',
  
   'PMLIBDIRS' => ['lib', 'Class', 'REST'],
);


WriteMakefile(%WriteMakefileArgs);