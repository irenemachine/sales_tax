class Growl
  
  attr_accessor :report, :status
  
  def initialize(report, opts = {})
    @report, options = report, create_options(opts)
    message = create_message
    
    opts = options.inject([]) do |arr, item|
      key, value = item.first, item.last
      (value.is_a?(Hash) ? arr.push("--#{key} '#{value[@status]}'") : arr.push("--#{key} '#{value}'"); arr;)
    end

    notifier = `which growlnotify`.chomp
    opts.unshift("-w -n RSpec")
    system %(#{notifier} #{opts.join(' ')} -m \"#{message}\" &)
    
  end
  
  private
  
  def create_message
    examples = @report.instance_variable_get(:@example_count).to_i
    failures = @report.instance_variable_get(:@failure_count).to_i
    pendings = @report.instance_variable_get(:@pending_count).to_i
    duration = @report.instance_variable_get(:@duration)
    @status  = (failures == 0) ? :pass : :fail
    "#{examples} Examples - #{failures} Failures - #{pendings} Pending"
  end
  
  def create_options(opts)
    {:title     => "Test Results", 
     :image     => {:pass => File.expand_path('~/.watchr_images/passed.png'), :fail => File.expand_path('~/.watchr_images/failed.png')},
     :priority  => {:pass => 0, :fail => 2}     
     }.merge!(opts)
  end

  
end