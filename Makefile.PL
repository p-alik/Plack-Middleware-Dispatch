use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'Plack::Middleware::Dispatch',
    AUTHOR             => q{Alexei Pastuchov <palik@cpan.org>},
    VERSION_FROM       => 'lib/Plack/Middleware/Dispatch.pm',
    ABSTRACT_FROM      => 'lib/Plack/Middleware/Dispatch.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES           => {},
    MIN_PERL_VERSION   => 5.006,
    CONFIGURE_REQUIRES => { "ExtUtils::MakeMaker" => 0, },
    BUILD_REQUIRES     => {
        "Test::More"      => 0,
        "Test::Exception" => 0,
        "Plack::Builder"  => 0,
        "Plack::Test"     => 0,
    },
    PREREQ_PM => {
        "Plack::Middleware"     => 0,
        "Plack::Util::Accessor" => 0,
        "Plack::Request"        => 0,
        "Scalar::Util"          => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'Plack-Middleware-Dispatch-*' },
);
