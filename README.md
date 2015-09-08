Plack::Middleware::Dispatch aims to provide simple list based request handling


```perl

use Plack::Builder;

my $foo = Foo->new() # Foo should provide dispatch method

my $app = sub { ... };
builder {
  enable "Dispatch", dispatch => [\&cb, $foo];
  $app;
};

  # cb(Plack::Request)
sub cb {
  my($req) = @_;
    ...
}

```
