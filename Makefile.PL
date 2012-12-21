use strict;
use warnings;

use ExtUtils::MakeMaker;
use ExtUtils::MakeMaker::Config;

my $output = WriteMakefile(
    NAME           => 'Net::IP::XS',
    AUTHOR         => 'Tom Harrison <tomhrr@cpan.org>',
    VERSION_FROM   => 'lib/Net/IP/XS.pm',
    ABSTRACT_FROM  => 'lib/Net/IP/XS.pm',
    PERL_MALLOC_OK => 1,
    OBJECT         => '$(O_FILES)',
    clean          => { FILES => '$(O_FILES)' },
    PREREQ_PM      => { 'Tie::Simple'         => 0,
                        'Math::BigInt'        => 0,
                        'IP::Authority'       => 0,
                        # Test prereqs.
                        'Test::More'          => 0,
                        'IO::Capture::Stderr' => 0 },
);

1;
