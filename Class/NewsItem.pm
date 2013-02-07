package Kayako::Class::NewsItem;
use strict;
use warnings;
use Class::Accessor "antlers";

id => ( is  => 'ro' );
staffid => ( is  => 'ro' );
newstype => ( is  => 'ro' );
newsstatus => ( is  => 'ro' );
author => ( is  => 'ro' );
email => ( is  => 'ro' );
subject => ( is  => 'ro' );
emailsubject => ( is  => 'ro' );
dateline => ( is  => 'ro' );
expiry => ( is  => 'ro' );
issynced => ( is  => 'ro' );
totalcomments => ( is  => 'ro' );
uservisibilitycustom => ( is  => 'ro' );
usergroupidlist => ( is  => 'ro' );
staffvisibilitycustom => ( is  => 'ro' );
staffgroupidlist => ( is  => 'ro' );
allowcomments => ( is  => 'ro' );
contents => ( is  => 'ro' );
categories => ( is  => 'ro' );

1;