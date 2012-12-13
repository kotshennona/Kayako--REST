use strict;
use Test::Simple tests => 13;
use Kayako::REST; 

my $tokens_ref = { api_key => '',
	secret_key => '',
	url => 'https://support.mfisoft.ru/fusion/api/index.php?e='};
			
my $client = Kayako::REST->new($tokens_ref);
my $response;
my $id;

# 1.
ok( defined($client) && ref $client eq 'Kayako::REST', 'new() works' );

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

# 7.
ok($client->GetTicketStatuses->is_success,'Get  Statuses list');

# 8.
ok($client->GetTicketStatus(1)->is_success,'Get  status by id');

# 9.
ok($client->GetAllUsers({})->is_success,'Get  user list');

# 10.
$response = $client->AddUser({fullname=>'Test Test2',usergroupid=>'2',password=>'qweasdzxc',email=>'test3@domain.com'});
ok($response->is_success,'Created a user');

# 11.
$id = $1 if $response->decoded_content =~ m!\<id\>.*?(\d+).*?\<\/id\>!;
print "ID is: $id\n";
ok($client->GetUser($id)->is_success,'Get  user by id');

# 12.
$response = $client->UpdateUser($id,{fullname=>'Test Renamed'});
print $response->decoded_content;
ok($response->is_success,'Updated user');

# 13.
ok($client->DeleteUser($id)->is_success,'Deleted  user');


