#!/bin/bash

# #################################### #
#             HELPER FUNCTIONS         #
# #################################### #

# This function checks that a constraint (first param) exists in a policy (second param) as deny all or allow all.
# Third parameters is "deny" or "allow"
# Returns true if everything's ok, false otherwise
function check_list_policy_all {
  CONSTRAINT="$1"
  POLICY="$2"
  BEHAVIOR="$3"
  RESULT="false"

  if [[ "$BEHAVIOR" = "deny" ]]
  then
    RESULT=$(echo "$POLICY" | jq -r --arg const "$CONSTRAINT" '(.[]) | select(.constraint==$const) | .listPolicy.allValues=="DENY"')
  elif [[ "$BEHAVIOR" = "allow" ]]
  then
    RESULT=$(echo "$POLICY" | jq -r --arg const "$CONSTRAINT" '(.[]) | select(.constraint==$const) | .listPolicy.allValues=="ALLOW"')
  elif [[ "$BEHAVIOR" = "default" ]]
  then
    RESULT=$(echo "$POLICY" | jq -r --arg const "$CONSTRAINT" '(.[]) | select(.constraint==$const) | .restoreDefault != null')
  fi

  if [[ "$RESULT" = "" ]]
  then
    RESULT="false"
  fi

  echo "$RESULT"

}

# This function checks that a constraint (first param) exists in a policy (second param) as deny or allow for the specified values.
# Third parameters is "deny" or "allow"
# Fourth param is the list of denied/allowed values (separated by ,)
# Returns true if everything's ok (all the values are in the policy), false otherwise
function check_list_policy_values {
  CONSTRAINT="$1"
  POLICY="$2"
  BEHAVIOR="$3"
  VALUES="$4"
  RESULT="false"
  IFS="," read -ra VALUES_ARRAY <<< "$VALUES"
  FALSE_COUNT=0

  for VALUE in "${VALUES_ARRAY[@]}"
  do
    if [[ "$BEHAVIOR" = "deny" ]]
    then
      RESULT=$(echo "$POLICY" | jq -r --arg const "$CONSTRAINT" --arg value "$VALUE" '(.[]) | select(.constraint==$const) | .listPolicy.deniedValues | contains([$value])')
    elif [[ "$BEHAVIOR" = "allow" ]]
    then
      RESULT=$(echo "$POLICY" | jq -r --arg const "$CONSTRAINT" --arg value "$VALUE" '(.[]) | select(.constraint==$const) | .listPolicy.allowedValues | contains([$value])')
    fi

    if [[ "$RESULT" != "true" ]]
    then
      FALSE_COUNT=$((FALSE_COUNT + 1))
    fi
  done

  if [[ $FALSE_COUNT -gt 0 ]]
  then
    RESULT="false"
  fi

  echo "$RESULT"

}