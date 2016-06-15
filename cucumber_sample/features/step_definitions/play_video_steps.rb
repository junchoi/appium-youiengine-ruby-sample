Given(/^that I am on the player screen$/) do
  page_source = driver.page_source

  xml = Nokogiri::XML(page_source)

  puts "Before click:\n#{xml}"
end

When(/^I tap on the play button$/) do
  # @play_button = driver.find_element(:name, "Btn-PlayPause")
  # @play_button.click
end

Then(/^I the video should play$/) do
  page_source = driver.page_source
  
  xml = Nokogiri::XML(page_source)

  puts "After click:\n#{xml}"
end
