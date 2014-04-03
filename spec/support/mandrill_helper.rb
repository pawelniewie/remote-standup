require 'pathname'
require 'json'

module MandrillHelper

  def mandrill_examples_path
    Pathname.new(File.dirname(__FILE__)).join('..', 'fixtures', 'mandrill_examples')
  end

  # Returns the JSON representation of an array of +sample_name+ events
  def mandrill_example_events(sample_name)
    sample_path = mandrill_examples_path.join("#{sample_name}.json")
    JSON.parse(sample_path.read)
  end

  # Returns the JSON representation of an +sample_name+ event
  def mandrill_example_event(sample_name)
    data = mandrill_example_events(sample_name).first
    if data['raw_params'] && (mandrill_events_data = data['raw_params']['mandrill_events'])
      data['raw_params']['mandrill_events'] = URI.decode_www_form_component(mandrill_events_data)
    end
    data
  end

  def payload_examples_path
    Pathname.new(File.dirname(__FILE__)).join('..','fixtures','payload_examples')
  end

  # Returns the content of +sample_name+ payload example filename
  def payload_example(sample_name)
    payload_examples_path.join(sample_name).read
  end


end

RSpec.configure do |conf|
  conf.include MandrillHelper
end