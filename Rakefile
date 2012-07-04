#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

namespace :server do
  task :build => :clean do
    system "cd server && make"
  end

  task :clean do
    system "cd server && make clean"
  end
end

Derpchat::Application.load_tasks
