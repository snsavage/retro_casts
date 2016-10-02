$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
require 'vcr'
require 'retro_casts'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

