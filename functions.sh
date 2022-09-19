#!/usr/bin/env bash

function check_sane() {
	for var in "${expected_vars[@]}"
	do
		if [[ -z "$var" ]]; then
			echo "This script should not normally be invoked directly; run install.sh instead."
			echo

			./install.sh --help
			exit 1
		fi
	done
	
	if [[ `id -u` != 0 ]]; then
		echo "This script must be run as root."
		exit 1
	fi
}

function log_start_region() {
	echo ">> $1"
}

function log_region_item() {
	log_region_pad
	echo "❖ $1"
}

function log_region_subitem() {
	log_region_pad
	echo "  └ $1"
}

function log_end_region() {
	log_region_pad
	echo "✓ $1"
}

function log_region_pad() {
	echo -n "   "
}
