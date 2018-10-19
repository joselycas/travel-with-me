ENV["SINATRA_ENV"] ||= "development"
require_relative './config/environment'

require 'sinatra/activerecord/rake'

desc "A Console"
task :console do
  Pry.start
end
