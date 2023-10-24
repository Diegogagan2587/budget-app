require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(
      name: 'Diego Vidal',
      email: 'diego@mail.com',
      password: '123456'
    )
  end
  #then we proceed to test the user model
  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end
  it 'is not valid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid without a password' do
    @user.password = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid with a password less than 6 characters' do
    @user.password = '123'
    expect(@user).to_not be_valid
  end

  it 'is not valid with a duplicated email' do
    @user2 = User.create(
      name: 'Diego Lopez',
      email: 'diego@mail.com',  
      password: '123456'
    )
    expect(@user2).to_not be_valid
  end

  it 'is not valid with a wrong email format' do
    @user.email = 'diego.com'
    expect(@user).to_not be_valid
  end
end
