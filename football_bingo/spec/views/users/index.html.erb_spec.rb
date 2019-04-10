require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :email => "Email@email.com",
        :password =>"123456"
      ),
      User.create!(
        :name => "Name",
        :email => "Email2@email.com",
        :password =>"123456"

      )
    ])
  end

  # it "renders a list of users" do
  #   render
  #   assert_select "tr>td", :text => "Name".to_s, :count => 2
  #   assert_select "tr>td", :text => "Email".to_s, :count => 2
  # end
end
