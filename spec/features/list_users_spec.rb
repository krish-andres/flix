require 'spec_helper'

describe "Listing the users" do
  it "shows the list of users" do
    user1 = User.create!(user_attributes(name: "Larry", email: "larry@example.com"))
    user2 = User.create!(user_attributes(name: "Curly", email: "curly@example.com"))
    user3 = User.create!(user_attributes(name: "Moe", email: "moe@example.com"))

    sign_in(user1)
    
    visit users_url

    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.name)
    expect(page).to have_link(user3.name)
  end  
end
