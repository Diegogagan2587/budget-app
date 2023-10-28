require 'rails_helper'

RSpec.describe 'Home page', type: :system do
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

  it 'Whe user logs in, he is redirected to the categories page' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('New Category')
    expect(page).to have_content('Expenses in transportation')
    expect(page).to have_content('transactions')
    expect(page).to have_content('Total')
  end

  it 'For each category the  user can see their name, icon and total amount of all transactions' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'

    expect(page).to have_content('Expenses in transportation')
    expect(page).to have_content('Expenses in food')
    expect(page).to have_content('transactions: 2')
    expect(page).to have_content('transactions: 1')
    expect(page).to have_content('Total:')
    expect(page).to have_content('300.0')
    expect(page).to have_content('175.0')
    # we check that icons are displayed
    expect(page).to have_css("ion-icon[name*='bicycle-outline']")
    expect(page).to have_css("ion-icon[name*='fast-food-outline']")
  end

  it 'When user clicks on a category, he is redirected to the category page' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    click_on 'Expenses in transportation'
#    sleep 200
    expect(page).to have_current_path(group_path(@category_one))
  end

  it 'should redirect to add new category page when user clicks on new category button' do
    visit '/splash'
    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
    click_on 'New Category'
    #The we check that we are redirected to the new category page
    expect(page).to have_current_path(new_group_path)
  end
end
