use v5.14;
use warnings;
use Encode;
use utf8;

use Test::More;
use Data::Dumper;

use lib 't';
use Util;

is(jq(qw(--IN date 2021 t/hash.json))->run->{result}, 0, "hash.json");

line(jq(qw(--IN author utashiro t/hash.json -o))->run->{stdout}, 108, "author");
line(jq(qw(--IN author utashiro t/array.json -o))->run->{stdout}, 108, "author (array)");

line(jq(qw(--IN commit.author utashiro t/hash.json -o))->run->{stdout}, 24, "commit.author");
line(jq(qw(--IN commit.author utashiro t/array.json -o))->run->{stdout}, 24, "commit.author (array)");

line(jq(qw(--IN commit.author.email utashiro t/hash.json -o))->run->{stdout}, 8, "commit.author.email");

line(jq(qw(--IN .commit.author.email utashiro t/hash.json -o))->run->{stdout}, 8, ".commit.author.email");

line(jq(qw(--IN parents github t/hash.json -o))->run->{stdout}, 8 * 4, "parents github");

done_testing;

__DATA__
