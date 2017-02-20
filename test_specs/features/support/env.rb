require 'rubygems'
require 'rest-client'
require 'parallel_tests'

$browser = ENV['BROWSER'] # IE, CH, FF
api_username = ENV['API_USERNAME']
api_password = ENV['API_PASSWORD']

Dir::mkdir('output') if not File.directory?('output')

Before do
  puts "TC Start time: #{Time.now.strftime('%m/%d/%Y %H:%M%p')}"
end

After do |scenario|
  if scenario.failed?
    case scenario
      when Cucumber::Core::Ast::Scenario
        @scenario_name = scenario.name
      else
        @scenario_name = scenario.scenario_outline.name
        #raise('Unhandled class')
    end
  end
end