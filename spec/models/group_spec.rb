require 'rails_helper'

RSpec.describe Group, type: :model do
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
  end

  # then we proceed to test the Group model
  it 'is valid with valid attributes' do
    expect(@group).to be_valid
  end

  it 'is not valid without a name' do
    @group.name = nil
    expect(@group).to_not be_valid
  end

  it 'is not valid without an user' do
    @group.user = nil
    expect(@group).to_not be_valid
  end

  it 'is valid with entities' do
    @group.entities << @entity_oil
    expect(@group).to be_valid
  end

  it 'It should inlcude the entities' do
    expect(@group.entities).to include(@entity_fuel)
  end
end
