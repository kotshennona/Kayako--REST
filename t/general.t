use strict;
use Test::Simple tests => 6;
use Kayako::Client; 

my $tokens_ref = { api_key => 'fbf0cf3b-f56d-67e4-bda8-cf45b69d3a3b',
	secret_key => 'ZWFiNjBiYjUtMjI5ZC0xZmI0LTkxZjctNjI3OGVjZWIyNWQ1YWVmYjlkYzYtOTUxMC0zNGM0LTNkOTgtMDc4NjMyN2Q5OTU1',
	url => 'https://support.mfisoft.ru/fusion/api/index.php?'};
			
my $client = Kayako::Client->new($tokens_ref);

# 1.
ok( defined($client) && ref $client eq 'Kayako::Client', 'new() works' );

# 2.
ok ($client->GetApiKey eq $tokens_ref->{api_key});

# 3.
ok ($client->GetSecretKey eq $tokens_ref->{secret_key});

# 4.
ok ($client->GetUrl eq $tokens_ref->{url});

# 5.
ok($client->GetCustomFields->is_success,'Get customfields list');

# 6.
ok($client->GetCustomFieldOptions(1)->is_success,'Get list of options for particular CF ID');