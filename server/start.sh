#!/bin/sh
CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PORT=8082 \
  erl -sname chat_server -pa $CURDIR/ebin -pa $CURDIR/deps/*/ebin -s chat_server
