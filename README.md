Plack::Middleware::Dispatch::GP
==============================

The repository contains two [PSGI](http://plackperl.org/) middleware packages.


[![CPAN version](https://badge.fury.io/pl/Plack-Middleware-Dispatch-GP.png)](https://badge.fury.io/pl/Plack-Middleware-Dispatch-GP)
[![Build Status](https://travis-ci.org/p-alik/Plack-Middleware-Dispatch-GP.png)](https://travis-ci.org/p-alik/Plack-Middleware-Dispatch-GP)
[![Coverage Status](https://coveralls.io/repos/github/p-alik/Plack-Middleware-Dispatch-GP/badge.png)](https://coveralls.io/github/p-alik/Plack-Middleware-Dispatch-GP)

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
