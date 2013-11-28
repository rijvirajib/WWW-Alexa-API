use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'WWW::Alexa::API',
    AUTHOR           => q{Rijvi Rajib <me@rij.co>},
    VERSION_FROM     => 'lib/WWW/Alexa/API.pm',
    ABSTRACT_FROM    => 'lib/WWW/Alexa/API.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
        'XML::Hash::LX'     => 0.0603,
        'LWP::UserAgent'    => 6
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'WWW-Alexa-API-*' },
);
