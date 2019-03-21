require 'rspec/core'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe MoviesController do
  describe 'index functions' do
    it 'allows sorting by title' do
      post :sort => :title
    end
    it 'allows sorting by release date' do
      post :sort => :release_date
    end
  end
end