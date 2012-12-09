use strict;
use Test::Simple tests => 1;
use Kayako::Client; 

my $client = Kayako::Client->new({ api_key => 'fbf0cf3b-f56d-67e4-bda8-cf45b69d3a3b',
	secret_key => 'ZWFiNjBiYjUtMjI5ZC0xZmI0LTkxZjctNjI3OGVjZWIyNWQ1YWVmYjlkYzYtOTUxMC0zNGM0LTNkOTgtMDc4NjMyN2Q5OTU1',
	url => 'https://support.mfisoft.ru/fusion/api/index.php?',
				});
				
ok( defined($client) && ref $client eq 'Kayako::Client', 'new() works' );
