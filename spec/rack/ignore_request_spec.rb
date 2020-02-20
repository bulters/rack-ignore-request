require 'rack'

RSpec.describe Rack::IgnoreRequest do
  it 'has a version number' do
    expect(Rack::IgnoreRequest::VERSION).not_to be nil
  end

  it 'default configuration is /monitor' do
    expect(Rack::IgnoreRequest.configuration.ignore_path).to eq '/monitor'
  end

  let(:app_response) { [200, { 'Content-Type' => 'text/plain' }, %w(OK)] }
  let(:app) { lambda { |env| response } }

  before do
    allow(app)
      .to receive(:call)
      .and_return(app_response)
  end

  subject { described_class.new(app) }

  describe '#call' do
    context 'when the pathame is /monitor' do
      it 'return 200' do
        expect(app).not_to receive(:call)
        status, _, _ = Rack::MockRequest.new(subject).get('/monitor')
        expect(status).to be 200
      end
    end

    context 'when the pathname is not /monitor' do
      it 'call env on app' do
        expect(app).to receive(:call)
        Rack::MockRequest.new(subject).get('/')
      end
    end
  end

  describe 'configuration' do
    before do
      Rack::IgnoreRequest.configure do |config|
        config.ignore_path = '/ignore_path'
      end
    end

    context 'when the pathame is from config ignore_path' do
      it 'return 200' do
        expect(app).not_to receive(:call)
        status, _, _ = Rack::MockRequest.new(subject).get('/ignore_path')
        expect(status).to be 200
      end
    end

    context 'when the pathname is not config ignore_path' do
      it 'call env on app' do
        expect(app).to receive(:call)
        Rack::MockRequest.new(subject).get('/monitor')
      end
    end  end
end
