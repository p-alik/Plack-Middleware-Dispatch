The repository contains two PSGI middleware packages.

- <b>Plack::Middleware::Dispatch::GP</b> - general purpose dispatcher aims to provide a possibility list based env handling

```perl

use Plack::Builder;

my $foo = Foo->new() # Foo should provide dispatch method

my $app = sub { ... };
builder {
  enable "Dispatch::GP", dispatch => [\&cb, $foo];
  $app;
};

# cb(Plack::Request)
sub cb {
  my($env) = @_;
    ...
}

```

<b>Plack::Middleware::Dispatch::GP::Request</b> - derived module aims to provide a possibility list based request handling

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
