#!/usr/bin/ruby
begin
  require 'irb/completion'
  require 'rubygems'
  require 'pry'
  require 'awesome_print'
rescue LoadError => e
  p e
end

if defined?(Pry)
  Pry.start
  exit
end
