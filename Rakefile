#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

namespace :server do
  desc 'build the erlang websocket server'
  task :build do
    system "cd server && make"
  end

  desc 'clean the server directory'
  task :clean do
    system "cd server && make clean"
  end
end

Derpchat::Application.load_tasks
