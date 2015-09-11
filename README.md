The repository contains two PSGI middleware packages.

- _Plack::Middleware::Dispatch::GP_ - general purpose dispatcher aims to provide a possibility list based env handling

```perl

use Plack::Builder;

my $foo = Foo->new() # Foo should provide dispatch method

my $app = sub { ... };
builder {
  enable "Dispatch::GP", dispatch => [\&cb, $foo];
  $app;
};

sub cb {
  my($env) = @_;
    ...
}

```

- _Plack::Middleware::Dispatch::GP::Request_ - derived module aims to provide a possibility list based request handling

```perl

use Plack::Builder;

my $app = sub { ... };
builder {
  enable "Dispatch::GP::Request", dispatch => [\&cb, ...];
  $app;
};

# cb(Plack::Request)
sub cb {
  my($req) = @_;
    ...
}

```

see http://plackperl.org/
