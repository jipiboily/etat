$:.unshift File.expand_path('../lib', __FILE__)

require 'rspec'
require 'sqlite3'
require 'factory_girl_rails'

require 'etat'


# Require support directory
Dir[File.expand_path('../../spec/support/**/*.rb', __FILE__)].map(&method(:require))

require 'factories'

RSpec.configure do |config|
  config.before(:each) do
    FakeModel.delete_all
  end

  config.before(:all) do
    Etat::SpecHelper::Database.create_database
  end

  config.after(:all) do
    Etat::SpecHelper::Database.delete_database
  end
end