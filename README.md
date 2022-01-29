# NAME

greple -Mjq - greple module for jq frontend

# SYNOPSIS

greple -Mjq --glob foo.json --IN label pattern

# DESCRIPTION

This is an experimental module for [App::Greple](https://metacpan.org/pod/App::Greple) command to provide
interface for [jq(1)](http://man.he.net/man1/jq) command.

You can search object `.commit.author.name` includes `Marvin` like this:

    greple -Mjq --IN .commit.author.name Marvin data.json

Please be aware that this is just a text matching tool for indented
result of [jq(1)](http://man.he.net/man1/jq) command.  So `.commit.author` includes everything
under it and it maches `committer` filed name.

# CAUTION

[greple(1)](http://man.he.net/man1/greple) commands read entire input before processing.  So it
should not be used for large amount of data or inifinite stream.

# OPTIONS

- **--IN** _label_ _pattern_

    Search _pattern_ included in _label_ field.

    Chacater `%` can be used as a wildcard in _label_ string.  So
    `%name` matches labels end with `name`, and `name%` matches labels
    start with `name`.

    If the label is simple string like `name`, it matches any level of
    JSON data.

    If the label string contains period (`.`), it is considered as a
    nested labels.  Name `.name` maches only `name` label at the top
    level.  Name `process.name` maches only `name` entry of some
    `process` hash.

    If labels are separated by two or more dots (`..`), they don't have
    to have direct relationship.

# LABEL SYNTAX

- **.file**

    `file` at the top level.

- **.file.path**

    `path` under `.file`.

- **.file..path**

    `path` in descendants of `.file`.

- **path**

    `path` at any level.

- **file.path**

    `file.path` at any level.

- **file..path**

    Some `path` in descendatns of some `file`.

- **%path**

    Any labels end with `path`.

- **path%**

    Any labels start with `path`.

- **%path%**

    Any labels include `path`.

# EXAMPLES

Search from any `name` labels.

    greple -Mjq --glob procmon.json --IN name _mina

Search from `.process.name` label.

    greple -Mjq --glob procmon.json --IN .process.name _mina

Object `.process.name` contains `_mina` and `.event` contains
`FORK`.

    greple -Mjq --glob procmon.json --IN .process.name _mina --IN .event FORK

Object `ancestors` contains `339` and `.event` contains `FORK`.

    greple -Mjq --glob procmon.json --IN ancestors 339 --IN event FORK

Object `*pid` labels contains 803.

    greple -Mjq --glob procmon.json --IN %pid 803

Object any <path> contains `_mira` under `.file` and `.event` contains `WRITE`.

    greple -Mjq --glob filemon.json --IN .file..path _mina --IN .event WRITE

# SEE ALSO

[App::Greple](https://metacpan.org/pod/App::Greple), [https://github.com/kaz-utashiro/greple](https://github.com/kaz-utashiro/greple)

[https://stedolan.github.io/jq/](https://stedolan.github.io/jq/)

# AUTHOR

Kazumasa Utashiro

# LICENSE

Copyright 2022 Kazumasa Utashiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
