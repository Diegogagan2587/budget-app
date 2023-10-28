require 'rails_helper'

RSpec.describe 'Splash Screen', type: :system do
  it 'displays in splash with Heading, and Login, Register buttons' do
    visit root_path
    expect(page).to have_content('Budget app')
    expect(page).to have_content('Login')
    expect(page).to have_content('Register')
  end
  it 'Redirect to login page when click on login button' do
    visit root_path
    click_on 'Login'
    expect(page).to have_content('Log in')
    expect(page).to have_content('Remember me')
    expect(page).to have_content('Forgot your password?')
  end
end
