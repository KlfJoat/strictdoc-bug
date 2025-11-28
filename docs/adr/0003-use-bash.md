<!--
SPDX-FileType: DOCUMENTATION
SPDX-FileType: TEXT
SPDX-License-Identifier: CC-BY-NC-SA-4.0
SPDX-FileCopyrightText: © 2014 - 2024
SPDX-FileContributor: KlfJoat
-->

# 3. Use bash

Date: 2014-05-03

## Status

Accepted

## Context

At its core, the operations performed by this suite could largely be run manually on the command line, along with some human transformation, recognition, and adaptation. That screams for the use of shell scripting rather than some other interpreted or compiled language.

`bash` is the shell I know the best and there is no point in learning a new one at this time in computing history.

## Decision

Use `bash` as the main programming language.

## Consequences

* `bash` is not seen as a "real programming language" by infidels and programmers, so there may not be good support for creating large scripts in IDEs, etc.
* It's easy to perform preliminary tests of specific commands simply on the command line.
* Bats testing is a thing, but I'm not sure how easy or hard it is to do.
