$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'yrb'
require 'spec'
require 'spec/autorun'

require 'stubs'

Spec::Runner.configure do |config|
  
end
