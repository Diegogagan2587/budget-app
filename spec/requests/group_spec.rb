require 'rails_helper'

RSpec.describe Group, type: :request do
  # we include devise authenticaton helpers in next line
  include Warden::Test::Helpers
  before(:each) do
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
    @entity_oil = Entity.create(
      author: @user,
      name: 'Motorcicle Oil 1 lt',
      amount: 150
    )
    # We autenticate the user usin devise test helpers
    login_as(@user, scope: :user)
  end
  describe 'GET /index' do
    it 'renders a successful response' do
      get groups_path
      expect(response).to be_successful
    end

    it 'renders a 200 response' do
      get groups_path
      expect(response).to have_http_status '200'
    end
    it 'can access to the a Group' do
      get group_path(@group)
      expect(response).to be_successful
    end

    it 'renders a index template' do
      get groups_path
      expect(response).to render_template(:index)
    end

    it 'renders a show template' do
      get group_path(@group)
      expect(response).to render_template(:show)
    end
  end
end
