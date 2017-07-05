# if Rails.env == 'development'
#   require 'rack-mini-profiler'
#
#   # initialization is skipped so trigger it
#   Rack::MiniProfilerRails.initialize!(Rails.application)
#   use Rack::MiniProfiler
#   run lambda { |env|
#     [200, {'Content-Type' => 'text/html'}, ["<html><body>hello!</body></html>"]]
#   }
# end
