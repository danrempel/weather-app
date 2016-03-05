require 'rubygems'
require 'yahoo_weatherman'

class Weather
  def self.location(location)
    @location = location
  end

  def self.current
    client = Weatherman::Client.new
    response = client.lookup_by_woeid(@location)
    locale = response.location['city']
    condition = response.condition['text']
    temp = response.condition['temp']
    puts "\nThe current conditions for #{locale} are #{temp} and #{condition}."
  end
  
  def self.forecast
    client = Weatherman::Client.new
    five_day = client.lookup_by_woeid(@location)
    five_day = five_day.forecasts
    puts "\nThe 5 day forecast is as follows:"
    five_day.each do |x|
      today = Time.now.strftime('%w').to_i
      day = x['date']
      weekday = day.strftime('%w').to_i
      if weekday == today
        dayName = 'Today'
      elsif weekday == today + 1
        dayName = 'Tomorrow'
      else
        dayName = day.strftime('%A')
      end
      puts "#{dayName} will be #{x['text']} with a low of #{x['low']} and a high of #{x['high']}*C."
    end
  end
end

print 'Welcome to the weather app. To get started, please enter the WOEID for your city. (WOEID can be found at http://woeid.rosselliot.co.nz/) WOEID: '
woeid = gets.chomp
Weather.location(woeid)
Weather.current
Weather.forecast
