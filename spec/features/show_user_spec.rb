require 'spec_helper'

describe "Showing a user" do
  
  it "shows the user's profile" do
    user = User.create!(user_attributes)
    
    sign_in(user)

    visit user_url(user)

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end
end
