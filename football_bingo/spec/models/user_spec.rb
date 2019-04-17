require 'rails_helper'

RSpec.describe User, type: :model do

    before(:each) do
        @user1 = create(:user)
    end
  
    it "is valid with valid attributes" do
      expect(@user1).to be_valid
    end

    it "has a unique email" do
        user2 = build(:user, name: "Ying")
        expect(user2).to_not be_valid
    end
    
    it "has a email that is not case_sensitive" do
        email2 = @user1.email.upcase
        user2 = build(:user, email: email2)
        expect(user2).to_not be_valid
    end    
    
    it "is not valid without a username" do
        user2 = build(:user, name: nil)
        expect(user2).to_not be_valid
    end
    
    it "is not valid without an email" do
        user2 = build(:user, email: nil)
        expect(user2).to_not be_valid
    end
  
    it "is not valid with a password less than 6" do
        user2 = build(:user, password: "12345")
        expect(user2).to_not be_valid
    end
    
    it "is not valid with a wrong email address" do
        user2 = build(:user, email: "user2")
        expect(user2).to_not be_valid
    end
  
end
