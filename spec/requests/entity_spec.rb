require 'rails_helper'

RSpec.describe EntitiesController, type: :request do
  # we include devise authenticaton helpers in next line
  include Warden::Test::Helpers
  before(:each) do
    # We set up variables to use in our tests
    @user = User.create(
      name: 'Diego Vidal',
      email: 'diego@mail.com',
      password: '123456'
    )
    @group = Group.create(
      user: @user,
      name: 'Expenses in transportation'
    )
    @entity_fuel = Entity.create(
      group: @group,
      author: @user,
      name: 'Motorcicle Fuel 12 lt',
      amount: 250
    )
    # We autenticate the user usin devise test helpers
    login_as(@user, scope: :user)
  end
  describe 'GET /index' do
    it 'renders a successful response' do
      get entities_path
      expect(response).to be_successful
    end

    it 'renders a 200 response' do
      get entities_path
      expect(response).to have_http_status '200'
    end

    it 'renders a index template' do
      get entities_path
      expect(response).to render_template(:index)
    end
  end
  describe 'GET /new' do
    it 'renders a successful response' do
      get new_entity_path
      expect(response).to be_successful
    end
    it 'renders a 200 response' do
      get new_entity_path
      expect(response).to have_http_status '200'
    end
    it 'renders a new template' do
      get new_entity_path
      expect(response).to render_template(:new)
    end
  end
  describe 'POST /create' do
    it 'renders a successful response' do
      post entities_path, params: { entity: { group: @group, name: 'Motorcicle Oil 1 lt', amount: 150 } }
      puts 'bebuggin after post'
      puts response.status
      expect(response).to be_successful
    end
    it 'renders a 200 response' do
      post entities_path, params: { entity: { group: @group, name: 'Motorcicle Oil 1 lt', amount: 150 } }
      expect(response).to have_http_status '200'
    end
    it 'renders a new template' do
      post entities_path, params: { entity: { group: @group, name: 'Motorcicle Oil 1 lt', amount: 150 } }
      expect(response).to render_template(:new)
    end
  end
end
