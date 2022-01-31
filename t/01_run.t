use v5.14;
use warnings;
use Encode;
use utf8;

use Test::More;
use Data::Dumper;

use lib 't';
use Util;

$ENV{NO_COLOR} = "1";

is(jq(qw(--IN date 2021 t/hash.json))->run->{result}, 0, "hash.json");

line(jq(qw(--IN author utashiro t/hash.json -o))->run->{stdout}, 108, "author");
line(jq(qw(--IN author utashiro t/array.json -o))->run->{stdout}, 108, "author (array)");

line(jq(qw(--IN commit.author utashiro t/hash.json -o))->run->{stdout}, 24, "commit.author");
line(jq(qw(--IN commit.author utashiro t/array.json -o))->run->{stdout}, 24, "commit.author (array)");

line(jq(qw(--IN commit.author.email utashiro t/hash.json -o --blockend=))->run->{stdout}, 4, "commit.author.email");

line(jq(qw(--IN .commit.author.email utashiro t/hash.json -o --blockend=))->run->{stdout}, 4, ".commit.author.email");

line(jq(qw(--IN parents github t/hash.json -o))->run->{stdout}, 8 * 4, "parents github");

line(jq(qw(--IN name Utashiro t/hash.json -o --blockend=))->run->{stdout}, 8, "name");
line(jq(qw(--IN author.name Utashiro t/hash.json -o --blockend=))->run->{stdout}, 4, "author.name");
like(jq(qw(--IN author.name Utashiro t/hash.json -o --blockend=))->run->{stdout}, qr/author/, "author.name match");
line(jq(qw(--IN committer.name Utashiro t/hash.json -o --blockend=))->run->{stdout}, 4, "committer.name");
like(jq(qw(--IN committer.name Utashiro t/hash.json -o --blockend=))->run->{stdout}, qr/committer/, "committer.name match");

line(jq(qw(--IN email . t/hash.json -o --blockend=))->run->{stdout}, 8, "email");
line(jq(qw(--IN commit.email . t/hash.json -o --blockend=))->run->{stdout}, 0, "commit.email");
line(jq(qw(--IN commit.author.email . t/hash.json -o --blockend=))->run->{stdout}, 4, "commit.author.email");
like(jq(qw(--IN commit.author.email . t/hash.json -o --blockend=))->run->{stdout}, qr/author/, "commit.author.email match");
line(jq(qw(--IN commit..email . t/hash.json -o --blockend=))->run->{stdout}, 4, "commit..email");
like(jq(qw(--IN commit..email . t/hash.json -o --blockend=))->run->{stdout}, qr/author/, "commit..email match");

done_testing;

__DATA__
