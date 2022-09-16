#!/usr/bin/ruby
begin
  require 'irb/completion'
  require 'rubygems'
  require 'pry'
rescue LoadError => e
  p e
end

if defined?(Pry)
  Pry.start
  exit
end
