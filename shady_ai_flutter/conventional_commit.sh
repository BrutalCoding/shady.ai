#!/bin/bash

# [YOUR_COMMIT_MESSAGE] is a copy of the commit string from ".git/COMMIT_EDITMSG"
YOUR_COMMIT_MESSAGE=$(HEAD -n1 "$1")
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
BRANCH_PATTERN="^(feature|fix|release)/BC-[[:digit:]]+-"
if ! [[ "$BRANCH_NAME" =~ $BRANCH_PATTERN ]]; then
  echo "Bad branch naming. Make sure your branch name follows the pattern $BRANCH_PATTERN"
  echo "Your branch name is $BRANCH_NAME" >&2
  echo "An example of a good branch name is feature/BC-1234: Add a new feature"
  exit 1
fi

CONVENTIONAL_COMMIT_PATTERN="^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\(.+\))?!?: .+"
if ! [[ "$YOUR_COMMIT_MESSAGE" =~ $CONVENTIONAL_COMMIT_PATTERN ]]; then
  echo "Bad commit message. Please use a message of the form that follows the conventional commit standard."  >&2
  # # Show what went wrong to the user
  echo "Your commit message: \"$YOUR_COMMIT_MESSAGE\"" >&2
  echo "Your commit message must comply to this pattern: $CONVENTIONAL_COMMIT_PATTERN" >&2
  echo "An example of a good commit message is \"feat: Added hello world pop-up\""
  exit 1
fi
