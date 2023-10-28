require 'rails_helper'

RSpec.describe 'Transaction page', type: :system do
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

  it 'Should dislay the list of transactions for a given category' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    click_on 'Expenses in transportation'

    expect(page).to have_content('Motorcicle Fuel 12 lt')
    expect(page).to have_content('Motorcicle Wheel')
  end

  it 'Should display the total amount of all transactions for a given category' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    click_on 'Expenses in transportation'
    # sleep 100
    expect(page).to have_content('Total: $')
    expect(page).to have_content('175.0')
  end
  it 'should redirect to the new transaction page when the user clicks on the new transaction button' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    click_on 'Expenses in transportation'
    click_on 'New Transaction'
    expect(page).to have_current_path(new_entity_path)
  end

  it 'should navigate to home page(groups or categories) when user click on < button' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    click_on 'Expenses in transportation'

    click_on 'Back'
    expect(page).to have_current_path(groups_path)
  end
end
