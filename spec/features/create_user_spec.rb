require 'spec_helper'

describe "Creating a user" do
  
  it "Creates a user and saves them to the database" do
    
    visit root_url
    click_link 'Sign Up'

    expect(current_path).to eq(signup_path)

    fill_in 'Name', with: "Example User"
    fill_in 'Email', with: "user@example.com"
    fill_in 'Username', with: "exampleuser"
    fill_in 'Password', with: "superfluous"
    fill_in 'Confirm Password', with: "superfluous"

    click_button 'Create Account'
    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_text("Example User")
    expect(page).to have_text("Account Successfully Created!")
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  it "does not save the user if it's invalid" do

    visit signup_url
    
    expect {
      click_button 'Create Account'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
  end
end
