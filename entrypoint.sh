#!/bin/sh

set -e

MIX_ENV=prod mix setup

/app/_build/prod/rel/es_cqrs_anatomy/bin/es_cqrs_anatomy start
