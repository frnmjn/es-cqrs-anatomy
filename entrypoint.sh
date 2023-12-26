#!/bin/sh

set -e

MIX_ENV=prod mix setup

/app/_build/prod/rel/escqrsanatomy/bin/escqrsanatomy start
