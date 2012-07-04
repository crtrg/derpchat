#!/bin/sh
PORT=8082 \
  erl -sname chat_server -pa ebin -pa deps/*/ebin -s chat_server
