#!/bin/bash

# #################################### #
#             HELPER FUNCTIONS         #
# #################################### #

# This function checks that a constraint (first param) exists in a policy (second param).
# Third parameter controls whether it's enforced or not
# Returns true if everything's ok, false otherwise
function check_boolean_policy {
  CONSTRAINT="$1"
  POLICY="$2"
  ENFORCED="$3"
  RESULT="false"

  if [[ "$ENFORCED" = "true" ]]
  then
    RESULT=$(echo "$POLICY" | jq -r --arg const "$CONSTRAINT" '(.[]) | select(.constraint==$const) | .booleanPolicy.enforced==true')
  elif [[ "$ENFORCED" = "false" ]]
  then
    RESULT=$(echo "$POLICY" | jq -r --arg const "$CONSTRAINT" '(.[]) | select(.constraint==$const) | .booleanPolicy.enforced==null')
  fi

  if [[ "$RESULT" = "" ]]
  then
    RESULT="false"
  fi

  echo "$RESULT"

}