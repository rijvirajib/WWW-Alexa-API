#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'WWW::Alexa::API' ) || print "Bail out!\n";
}

diag( "Testing WWW::Alexa::API $WWW::Alexa::API::VERSION, Perl $], $^X" );
