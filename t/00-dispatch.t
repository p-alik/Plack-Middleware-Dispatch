use 5.006;
use strict;
use warnings FATAL => 'all';

use Test::More;

package XXX;

sub new {
    return bless {}, shift;
}

sub dispatch {
    my ($self, $req) = @_;
    isa_ok($req, "Plack::Request", ref($self) . "->dispatch");
}
1;

use HTTP::Request::Common;

use Plack::Builder;
use Plack::Test;

use Test::More;
use Test::Exception;

my $cln = "Plack::Middleware::Dispatch";
use_ok($cln);

diag("Testing $cln $Plack::Middleware::Dispatch::VERSION, Perl $], $^X");

my $app = sub { return [200, ["Content-Type" => "text/plain"], ["OK"]] };

ok($cln->wrap($app, dispatch => \&cb), "wrap with dispatch");

subtest "catch exceptions", sub {
    throws_ok { $cln->wrap($app) } qr/$cln requires dispatch parameter/,
        "caught $cln->new complains about no dispatch parameter";

    throws_ok { $cln->wrap($app, dispatch => "foo") }
    qr/dispatch should be a code reference/,
        "caught $cln->new complains about dispatch parameter is not a code";

    my $b = bless {}, 'FOO::BAR';

    throws_ok { $cln->wrap($app, dispatch => $b) }
    qr/FOO::BAR doesn't provide dispatch()/,
        "caught $cln->new complains about dispatch parameter doesn't provide dispatch";
};

my %post = (foo => 'bar');
test_psgi app => builder {
    enable "Dispatch", dispatch => [XXX->new(), \&cb];
    $app;
},
    client => sub {
    my $cb = shift;
    my $res = $cb->(POST "http://localhost/", [%post]);
    is $res->code, 200;
    };

done_testing();

sub cb {
    my ($req) = @_;
    isa_ok($req, "Plack::Request", "cb");
    is($req->method, "POST", "POST request");
    isa_ok($req->parameters, "Hash::MultiValue");
    my %h = Hash::MultiValue->from_mixed($req->parameters)->flatten;
    foreach (keys %h) {
        is $h{$_}, $post{$_}, "post{$_}";
    }
} ## end sub cb

