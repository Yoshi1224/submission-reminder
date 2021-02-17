require 'bundler'
Bundler.require

require './app_main'
run Sinatra::Application

$stdout.sync = true