require 'rails_helper'

RSpec.describe Entity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @user = @user = User.create(
      name: 'Diego Vidal',
      email: 'diego@mail.com',
      password: '123456'
    )
    @group = Group.create(
      user: @user,
      name: 'Expenses in transportation'
    )
    @entity = Entity.create(
      group: @group,
      author: @user,
      name: 'Motorcicle Fuel 12 lt',
      amount: 250
    )
  end
  # then we proceed to test the Entity model
  it 'is valid with valid attributes' do
    expect(@entity).to be_valid
  end
  it 'is not valid without a name' do
    @entity.name = nil
    expect(@entity).to_not be_valid
  end

  it 'is not valid without an amount' do
    @entity.amount = nil
    expect(@entity).to_not be_valid
  end

  it 'is not valid without an author' do
    @entity.author = nil
    expect(@entity).to_not be_valid
  end

  it 'is not valid without a group' do
    @entity.group = nil
    expect(@entity).to_not be_valid
  end
end
