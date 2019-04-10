require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user1 = create(:user, name:"test", email:"test@email.com")
  end

  # it "renders attributes in <p>" do
  #   render
  #   expect(rendered).to include("test")
  #   expect(rendered).to match("test@email.com")
  # end
end
