FactoryBot.define do
  factory :translation do
    
  end
  factory :condition do
    
  end
  
  factory :user do
    name "Joe"
    email "test@test.com"
    #sequence(:email) { |n| "user_#{n}@factory.com" }
    password "123456"
  end
  
  factory :users do
    name "Joe"
    sequence(:email) { |n| "user_#{n}@factory.com" }
    password "123456"
  end
  
end