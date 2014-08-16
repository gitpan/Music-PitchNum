#!perl
#
# Music::PitchNum::German notation tests

use strict;
use warnings;

use Test::More;    # plan is down at bottom
use Test::Exception;

package Assay;
use Moo;
with('Music::PitchNum::German');

package main;
my $the = Assay->new;

##############################################################################
#
# pitchname

is( $the->pitchname(34), q{b,,} );
is( $the->pitchname(46), q{b,} );
is( $the->pitchname(58), q{b} );
is( $the->pitchname(70), q{b'} );
is( $the->pitchname(69), q{a'} );
is( $the->pitchname(72), q{c''} );
is( $the->pitchname(71), q{h'} );
is( $the->pitchname(95), q{h'''} );

dies_ok( sub { $the->pitchname('tar') }, 'pitch that is not pitch' );

##############################################################################
#
# pitchnum

is( $the->pitchnum(q{b,,}),  34 );
is( $the->pitchnum(q{b,}),   46 );
is( $the->pitchnum(q{b}),    58 );
is( $the->pitchnum(q{b'}),   70 );
is( $the->pitchnum(q{a'}),   69 );
is( $the->pitchnum(q{c''}),  72 );
is( $the->pitchnum(q{h'}),   71 );
is( $the->pitchnum(q{h'''}), 95 );

# accidentals
is( $the->pitchnum(q{cis''}),   73 );
is( $the->pitchnum(q{cisis''}), 74 );
is( $the->pitchnum(q{des''}),   73 );
is( $the->pitchnum(q{deses''}), 72 );

plan tests => 21;
