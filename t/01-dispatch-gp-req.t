use 5.006;
use strict;
use warnings FATAL => 'all';

my %post = (foo => 'bar');

package XXX;

use Hash::MultiValue;
use Test::More;
sub new {
    return bless {}, shift;
}

sub dispatch {
    my ($self, $req) = @_;
    isa_ok($req, "Plack::Request", ref($self) . "->dispatch");
    is($req->method, "POST", "POST request");
    isa_ok($req->parameters, "Hash::MultiValue");
    my %h = Hash::MultiValue->from_mixed($req->parameters)->flatten;
    foreach (keys %h) {
        is $h{$_}, $post{$_}, "post{$_}";
    }
}
1;

package main;
use HTTP::Request::Common;

use Plack::Builder;
use Plack::Test;

use Test::More;
use Test::Exception;

my $cln = "Plack::Middleware::Dispatch::GP::Request";
use_ok($cln);

diag("Testing $cln $Plack::Middleware::Dispatch::GP::Request::VERSION, Perl $], $^X");

my $app = sub { return [200, ["Content-Type" => "text/plain"], ["OK"]] };

my $d = XXX->new();
test_psgi app => builder {
    enable "Dispatch::GP::Request", dispatch => [$d, \&cb];
    $app;
},
    client => sub {
    my $cb = shift;
    my $res = $cb->(POST "http://localhost/", [%post]);
    is $res->code, 200;
    };

done_testing();

sub cb {
    $d->dispatch(@_);
} ## end sub cb

