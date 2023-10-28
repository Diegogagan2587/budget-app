require 'rails_helper'

RSpec.describe 'PAGE: Add New transaction', type: :system do
  before(:each) do
    User.destroy_all
    @user = User.create!(email: 'diego@mail.com', name: 'Diego vidal', password: '123456')
    @category_one = Group.create(
      user: @user,
      name: 'Expenses in transportation',
      icon: 'bicycle-outline'
    )
    @category_two = Group.create(
      user: @user,
      name: 'Expenses in food',
      icon: 'fast-food-outline'
    )

    @transaction_one = Entity.create(
      group: @category_one,
      author: @user,
      name: 'Motorcicle Fuel 12 lt',
      amount: 25
    )
    @transaction_one = Entity.create(
      group: @category_one,
      author: @user,
      name: 'Motorcicle Wheel',
      amount: 150
    )
    @transaction_one = Entity.create(
      group: @category_two,
      author: @user,
      name: 'Lunch with friends',
      amount: 300
    )
  end
  it 'Shoud be able to create a transaction with name, amount and category and save it' do
    # we naviage to Add new transaction page
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    click_on 'New transaction'
    # we fill in the form

    select 'Expenses in transportation', from: 'entity_group_id'
    fill_in 'Name', with: 'Testing Expense'
    fill_in 'Amount', with: 100
    click_on 'Save'
    # We evaluate if the new transaction is saved
    expect(page).to have_content('Testing Expense')
    expect(page).to have_content('100')
    expect(page).to have_css("ion-icon[name*='bicycle-outline']")
  end

  it 'User should be able to go back to home page' do
    # we naviage to Add new transaction page
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    click_on 'New transaction'

    # we clikc to go back to home page
    click_on '❮'

    # we check if the route is home page
    expect(page).to have_current_path(root_path)
  end
end
