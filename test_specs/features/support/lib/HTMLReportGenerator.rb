# ruby -r "./HTMLReportGenerator.rb" -e "HTMLReportGenerator.generateReport"
require_relative 'report_builder'

class HTMLReportGenerator
  def self.generateReport
    options = {
           json_path:    'output',
           report_path:  "output/API Test Report",
           report_types: [:html],
           report_tabs:  [:overview, :features, :scenarios, :errors],
           report_title: 'API Test Results',
           compress_images: false,
        }
    ReportBuilder.build_report options
  end
end