require 'settingslogic'

class Settings < Settingslogic
  source "./application.yml"
  namespace ENV['RACK_ENV']
end
