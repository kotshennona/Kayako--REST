use strict;
use Test::Simple tests => 4;
use Kayako::REST; 

my $id;
my $response;
my $client = Kayako::REST->new({ api_key => 'fbf0cf3b-f56d-67e4-bda8-cf45b69d3a3b',
	secret_key => 'ZWFiNjBiYjUtMjI5ZC0xZmI0LTkxZjctNjI3OGVjZWIyNWQ1YWVmYjlkYzYtOTUxMC0zNGM0LTNkOTgtMDc4NjMyN2Q5OTU1',
	url => 'https://support.mfisoft.ru/fusion/api/index.php?',
				});
# 1.
ok( defined($client) && ref $client eq 'Kayako::REST', 'new() works' );

# 2.
ok($client->GetAllDepartments->is_success,'Get a list of ALL Departments');

# 3.      
$response = $client->AddDepartment({'title' => 'TestDepartment', 'app' =>'livechat', 'type'=>'public', 'usergroupid[]'=>[1]});
print $response->decoded_content;

ok($response->is_success,'Create a new department');

# 4.
if ($response->is_success){
$response->decoded_content =~ m!\<id\>(\d*)\<\/id\>!;
$id = $1;
}

ok($client->GetDepartment($id)->is_success,'Get department by ID');

# 5.

ok($client->DeleteDepartment($id)->is_success,'Delete Department');
