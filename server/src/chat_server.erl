-module(chat_server).
-behaviour(application).
% -import(os, [getenv/1]).
-export([start/0, start/2, stop/1]).

start() ->
  application:start(cowboy),
  application:start(chat_server).

start(_Type, _Args) ->
  Dispatch = [
    {'_', [
        {[<<"io">>], websocket_handler, []},
        {[<<"public">>, '...'], cowboy_http_static, [
            {directory, <<"./public">>},
            {mimetypes, [
                {<<".html">>, [<<"text/html">>]},
                {<<".js">>,   [<<"application/javascript">>]},
                {<<".css">>,  [<<"text/css">>]}
              ]}
          ]}
      ]}
  ],
  Port = 8081, % getenv('PORT'),
  cowboy:start_listener(my_http_listener, 100,
    cowboy_tcp_transport, [{port, Port}],
    cowboy_http_protocol, [{dispatch, Dispatch}]
  ),
  chat_server_sup:start_link().

stop(_State) ->
  ok.
