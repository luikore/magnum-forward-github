require 'sinatra'
require 'json'
require "octokit"
require 'logger'
require "yaml"

CONFIG = YAML.load_file __dir__ + '/config.yml'
LOGGER = Logger.new __dir__ + '/app.log'
LOGGER.level = Logger::INFO

if ENV['test-status']
  get '/ci-forward-github/status' do
   'good'
  end
end

post '/ci-forward-github/' do
  payload = JSON.parse params['payload']
  if payload['project_id']
    client = Octokit::Client.new access_token: CONFIG[:access_token]

    state =\
      if payload['status'] =~ /pending|running/i
        'pending'
      elsif payload['result'] == 0
        'success'
      else
        'failure'
      end
    target_url = payload['build_url']
    description = "build #{payload['number']}"

    data = {state: state, target_url: target_url, description: description}
    res = client.post "/repos/#{CONFIG[:repo]}/statuses/#{payload['commit']}", data
    LOGGER.info [data, res].inspect
  end
  ''
end
