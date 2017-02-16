require 'rubygems'
require 'report_builder'
require 'rest-client'
require 'parallel_tests'

$browser = ENV['BROWSER'] # IE, CH, FF
api_username = ENV['API_USERNAME']
api_password = ENV['API_PASSWORD']

Before do
  puts "TC Start time: #{Time.now.strftime('%m/%d/%Y %H:%M%p')}"

  @apiutil = APIUtil.new(true,'superadmin')
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
    Dir::mkdir('output') if not File.directory?('output')
  end

  at_exit do
    dayValue = DateTime.now.day.to_s.length==1? '0' + DateTime.now.day.to_s : DateTime.now.day.to_s
    monthValue = DateTime.now.month.to_s.length==1? '0' + DateTime.now.month.to_s : DateTime.now.month.to_s
    dateValue = monthValue + '-' + dayValue + '-' + DateTime.now.year.to_s

    options = {
       json_path:    'output',
       report_path:  "output/ExecutionResults_#{dateValue}",
       report_types: ['html'],
       report_tabs:  ['overview', 'features', 'scenarios', 'errors'],
       report_title: "ExecutionResults_#{dateValue}",
       compress_images: false,
       additional_info: {'browser' => 'Chrome'}
     }

    ReportBuilder.build_report options
  end
end