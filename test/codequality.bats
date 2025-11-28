#!/usr/bin/env bats
# SPDX-FileType: SOURCE
# SPDX-FileType: TEXT
# SPDX-License-Identifier: AGPL-3.0-or-later
# SPDX-FileCopyrightText: © 2023 - 2024
# SPDX-FileContributor: KlfJoat


load "$BATS_TEST_DIRNAME/bats_helpers/bats-support/load"
load "$BATS_TEST_DIRNAME/bats_helpers/bats-assert/load"

# bats file_tags=generic
## bats test_tags=bats:focus

setup_file() {
  :
}


# Note the distinction that REUSE verifies that every file in the entire repo
# has any SPDX license and any copyright tag.
# Here, I will verify that _certain_ file types have _certain_ licenses
# AND verify the other SPDX tags I care about.

### SPDX license, copyright, contributor, & file type tags
# TODO: Add for other file types?
@test "SPDX-License-Identifier tag present & correct (AGPL-3.0-or-later) in every script" {
  local _script
  local -a _all_scripts

  # +bin/**
  # -*.conf
  mapfile -d '' _all_scripts < <(find "${BIN_DIR}" -maxdepth 1 -type f -name '*' -not -name '*.conf*' -print0 || true)
  # +test/*.bash
  # +test/*.sh
  mapfile -d '' -O ${#_all_scripts[@]} _all_scripts < <(find "$BATS_TEST_DIRNAME/" -maxdepth 1 -type f -name '*.bash' -print0 -o -type f -name '*.sh' -print0 || true)

  for _script in "${_all_scripts[@]}"; do
    # Brackets around ':' are so 'reuse lint' doesn't get tripped up by this regex.
    # --files-without-match is the only way to get the failing filename to print
    run  grep --line-regexp \
              '[[:blank:]]*# SPDX-License-Identifier[:] \+AGPL-3.0-or-later[[:blank:]]*' \
              --files-without-match \
              "${_script}"
    assert_success
    refute_output
  done
}

@test "SPDX-License-Identifier tag present & correct (CC-BY-NC-SA-4.0) in every documentation file" {
  local _doc
  local -a _all_docs

  # +docs/**/*.md
  # -External/**
  mapfile -d '' _all_docs < <(find "${DOCS_DIR}" -type d -name 'External' -prune -o -type f -name '*.md' -print0 || true)

  for _doc in "${_all_docs[@]}"; do
    # Brackets around ':' are so 'reuse lint' doesn't get tripped up by this regex.
    # --files-without-match is the only way to get the failing filename to print
    run  grep --line-regexp \
              '[[:blank:]]*SPDX-License-Identifier[:] \+CC-BY-NC-SA-4.0[[:blank:]]*' \
              --files-without-match \
              "${_doc}"
    assert_success
    refute_output
  done
}


### StrictDoc???
#
# Ensure AcceptanceCriteria.sdoc has at least 1 Parent Relation links
# * 0+ to User Stories
# * 1+ to Requirements
#
# Inline literals in RST are two backticks `` on either side, not one as in Markdown.
# In VSC:  Find  ([^`])(`)([^`])  (doesn't work at start of line) and replace with  $1``$3
# So  /[^`](`)[^`]/ s/`/``/g ?? (unvalidated)

