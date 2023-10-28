require 'rails_helper'

RSpec.describe 'Authentication and Registration', type: :system do
  before(:each) do
    User.destroy_all
    @user = User.create!(email: 'diego@mail.com', name: 'Diego vidal', password: '123456')
  end

  context 'when user does not have an account' do
    it 'Should register a new user with name, email and password' do
      visit root_path
      click_on 'Register'
      fill_in 'Email', with: 'diego2@mail.com'
      fill_in 'Name', with: 'Diego vidal'
      fill_in 'Password', with: '123456'
      # we fill in the password confirmation field
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'

      expect(page).to have_content('Welcome! You have signed up successfully')
    end
    context 'when user has an account' do
      it 'Should login using email and passwordclear' do
        visit root_path
        click_on 'Login'
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_on 'Log in'

        expect(page).to have_content('Signed in successfully.')
      end

      it 'Should not login a user with wrong password' do
        visit root_path
        click_on 'Login'
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: 'wrongpassword'
        click_on 'Log in'

        expect(page).to have_content('Invalid Email or password.')
      end
    end
  end
end
