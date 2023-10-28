# We will implement request test for SplashController
require 'rails_helper'

RSpec.describe SplashController, type: :request do
  describe 'GET /splash' do
    it 'should return 200' do
      get '/splash'
      expect(response).to have_http_status(200)
    end
    it 'should render the index template' do
      get '/splash'
      expect(response).to render_template(:index)
    end
  end
end
