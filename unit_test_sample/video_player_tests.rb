require_relative "test_helper"
require_relative "../common/common"

require 'selenium-webdriver'
require "awesome_print"

class VideoPlayerTests < AppiumTest
  include Common

  def before_all
    platform = ENV["APPIUM_PLATFORM"] || "Android"
    
    capabilities = load_caps_for platform

    Appium::Driver.new(capabilities)
    Appium.promote_appium_methods AppiumTest

    start_driver
  end

  def after_all
    dump_logs
    driver_quit
  end

  def setup
  end

  def teardown
  end

  # def test_show_commands
  #   puts "\nAvailable methods:\n"
  #   public_methods(true).sort!.each do |method|
  #     puts "\t#{method}"
  #   end
  #   puts "\n\n"
  # end

  def test_main_image_should_navigate_to_its_pdp
    expected_title        = "Big Buck Bunny"
    expected_duration     = "9:56"
    expected_genre        = "Adventure"
    expected_release_year = "2011"

    # Should be on the Lander Page
    wait = Selenium::WebDriver::Wait.new(:timeout => 30)

    movie_link = nil

    flunk unless wait.until  {
      elements = find_elements(:class, "LanderItemView")

      movie_link = elements.first
    }

    sleep(2) # ಠ_ಠ - Movie element exists but isn't clickable while animation is running

    movie_link.click

    flunk unless wait.until {
      find_element(:name, "Btn-WatchNow")
    }

    sleep(2) # ಠ_ಠ

    # Should be at the PDP for Big Buck Bunny
    assert_equal expected_title,        find_element(:name, 'placeholder-title').text
    assert_equal expected_duration,     find_element(:name, 'placeholder-duration').text
    assert_equal expected_genre,        find_element(:name, 'placeholder-genre').text
    assert_equal expected_release_year, find_element(:name, 'placeholder-releaseYear').text

    back_button = find_element(:name, "Btn-Back")
    back_button.click
    sleep(2)
  end

  def test_secondary_image_should_navigate_to_its_pdp
    expected_title        = "Caminandes: Llama Drama"
    expected_duration     = "1:30"
    expected_genre        = "Kids"
    expected_release_year = ""

    # Should be on the Lander Page
    wait = Selenium::WebDriver::Wait.new(:timeout => 30)

    movie_link = nil

    flunk unless wait.until {
      poster_list = find_element(:name, "PosterList")

      movie_link = poster_list.find_element(:name, "Caminandes: Llama Drama")
    }

    sleep(1) # ಠ_ಠ - Movie element exists but isn't clickable while animation is running

    movie_link.click

    flunk unless wait.until {
      find_element(:name, "Btn-WatchNow")
    }

    sleep(2) # ಠ_ಠ

    # Should be at the PDP for Caminandes: Llama Drama
    assert_equal expected_title,        find_element(:name, 'placeholder-title').text
    assert_equal expected_duration,     find_element(:name, 'placeholder-duration').text
    assert_equal expected_genre,        find_element(:name, 'placeholder-genre').text
    assert_equal expected_release_year, find_element(:name, 'placeholder-releaseYear').text
  end
end
