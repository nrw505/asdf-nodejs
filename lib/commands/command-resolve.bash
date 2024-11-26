#! /usr/bin/env bash

set -eu -o pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utils.sh"

legacy_strat="${ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY-}"
if [ -s "$legacy_strat" ]; then
	legacy_strat=$(get_asdf_config_value "nodejs_legacy_file_dynamic_strategy")
fi
queries=()

for arg; do
	case "$arg" in
	--latest-installed)
		legacy_strat=latest_installed
		;;

	--latest-available)
		legacy_strat=latest_available
		;;

	*)
		queries+=("$arg")
		;;
	esac
done

for query in "${queries[@]}"; do
	ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY="$legacy_strat" resolve_version "$query"
done
