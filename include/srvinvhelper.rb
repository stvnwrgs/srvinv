# encoding: utf-8
class Srvinvhelper
  require 'log4r'
  require 'log4r/outputter/syslogoutputter'
  include Log4r

  def initialize_logging(filename = 'output.log')
    format = PatternFormatter.new(:pattern => "[%l] %d :: %m", :date_pattern => "%Y-%m-%d %H:%M")
    file = FileOutputter.new('fileOutputter', :filename => File.join(File.dirname(__FILE__), '..', CONFIG['log']['path'], filename), :trunc => false)
    file.formatter = format

    syslog = SyslogOutputter.new('f1', :ident => 'srvinv')

    stdout = Outputter.stdout
    stdout.formatter = format

    @logger = Logger.new('srvinv')
    @logger.add(file, syslog, stdout)
  end

  def log(type = 'debug', message)
    method = @logger.method(type)
    method.call(message)
  end
end
