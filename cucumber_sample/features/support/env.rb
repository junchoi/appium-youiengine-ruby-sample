require "bundler" 
require 'rspec'
require 'rspec/expectations'
require 'appium_lib'
require 'cucumber/ast'
require 'nokogiri'
require 'byebug'

# Create a custom World class so we don't pollute `Object` with Appium methods
class AppiumWorld
end

opts = { caps: { platformName: "youi", deviceName: "127.0.0.1" }, port: 12345 }

Appium::Driver.new(opts)
Appium.promote_appium_methods AppiumWorld

World do
  AppiumWorld.new
end

Before { $driver.start_driver }
After { $driver.driver_quit }
