#!/bin/bash

function parseInputs {
  # Required inputs
  if [ "${INPUT_BB_ACTIONS_SUBCOMMAND}" != "" ]; then
    bbSubcommand=${INPUT_BB_ACTIONS_SUBCOMMAND}
  else
    echo "Input bb_actions_subcommand cannot be empty"
    exit 1
  fi

  # Optional inputs
  bbWorkingDir="."
  if [[ -n "${INPUT_BB_ACTIONS_WORKING_DIR}" ]]; then
    bbWorkingDir=${INPUT_BB_ACTIONS_WORKING_DIR%/}
  fi
}

function main {
  parseInputs

  cd ${GITHUB_WORKSPACE%/}/${bbWorkingDir}

  case "${bbSubcommand}" in
    postdeploy)
      blackbox_postdeploy
      ;;
    shred_all_files)
      blackbox_shred_all_files
      ;;
    *)
      echo "Error: Must provide a valid value for bb_actions_subcommand"
      exit 1
      ;;
  esac
}

main "${*}"
