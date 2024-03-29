#!perl

use 5.010000;

use strict;
use warnings;
use ExtUtils::MakeMaker;

# perhaps stolen from mauke/Dir-Self
sub merge_key_into {
  my ( $href, $target, $source ) = @_;
  %{ $href->{$target} } = ( %{ $href->{$target} }, %{ delete $href->{$source} } );
}

my %params = (
  NAME         => 'Music::PitchNum',
  ABSTRACT     => 'note name and pitch number utility roles',
  AUTHOR       => 'Jeremy Mates <jmates@cpan.org>',
  VERSION_FROM => 'lib/Music/PitchNum.pm',

  LICENSE  => 'perl',
  PL_FILES => {},

  CONFIGURE_REQUIRES => {
    'strict'              => 0,
    'ExtUtils::MakeMaker' => '6.48',
  },
  BUILD_REQUIRES => {},
  TEST_REQUIRES  => {
    'Moo::Role'       => 0,
    'Test::Exception' => 0,
    'Test::More'      => 0,
    'lib'             => 0,
  },
  PREREQ_PM => {
    'Moo::Role'    => 0,
    'Scalar::Util' => 0,
    'strict'       => 0,
  },

  META_MERGE => {
    'meta-spec' => { version => 2 },
    'resources' => {
      repository => {
        url  => 'git://github.com/thrig/Music-PitchNum.git',
        web  => 'https://github.com/thrig/Music-PitchNum',
        type => 'git',
      },
    },
  },
);

( my $mm_version = ExtUtils::MakeMaker->VERSION(
    $params{CONFIGURE_REQUIRES}{'ExtUtils::MakeMaker'}
  )
) =~ tr/_//d;

if ( $mm_version < 6.67_04 ) {
  # Why? For the glory of satan, of course!
  *ExtUtils::MM_Any::_add_requirements_to_meta_v1_4 =
    \&ExtUtils::MM_Any::_add_requirements_to_meta_v2;
}

if ( $mm_version < 6.63_03 ) {
  merge_key_into \%params, 'BUILD_REQUIRES', 'TEST_REQUIRES';
}

if ( $mm_version < 6.55_01 ) {
  merge_key_into \%params, 'CONFIGURE_REQUIRES', 'BUILD_REQUIRES';
}

if ( $mm_version < 6.51_03 ) {
  merge_key_into \%params, 'PREREQ_PM', 'CONFIGURE_REQUIRES';
}

WriteMakefile( ( MM->can('signature_target') ? ( SIGN => 1 ) : () ), %params );
