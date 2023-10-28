require 'rails_helper'

RSpec.describe 'PAGE: Add New Category', type: :system do
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
  it 'Shoud be able to create a category with name and icon and save it' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'

    click_on 'New Category'
    fill_in 'Name', with: 'Testing Category'
    radio_button = find('ion-icon[name="card-outline"]')
    radio_button.click
    click_on 'Save'
    # since it will redirect to home page, we should see the new category there
    expect(page).to have_content('Testing Category')
    expect(page).to have_css("ion-icon[name*='card-outline']")
  end

  it 'should be able to get back to home page without saving' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'

    click_on 'New Category'
    fill_in 'Name', with: 'Testing Category'
    click_on '❮'
    expect(page).to have_content('Expenses in transportation')
    expect(page).to have_current_path(groups_path)
  end
end
