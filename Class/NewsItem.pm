package Kayako::Class::NewsItem;
use strict;
use warnings;
use Class::Accessor "antlers";

has id => ( is  => 'ro' );
has staffid => ( is  => 'ro' );
has newstype => ( is  => 'ro' );
has newsstatus => ( is  => 'ro' );
has author => ( is  => 'ro' );
has email => ( is  => 'ro' );
has subject => ( is  => 'ro' );
has emailsubject => ( is  => 'ro' );
has dateline => ( is  => 'ro' );
has expiry => ( is  => 'ro' );
has issynced => ( is  => 'ro' );
has totalcomments => ( is  => 'ro' );
has uservisibilitycustom => ( is  => 'ro' );
has usergroupidlist => ( is  => 'ro' );
has staffvisibilitycustom => ( is  => 'ro' );
has staffgroupidlist => ( is  => 'ro' );
has allowcomments => ( is  => 'ro' );
has contents => ( is  => 'ro' );
has categories => ( is  => 'ro' );

1;