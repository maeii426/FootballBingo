FactoryBot.define do
  factory :drife, class: 'Drive' do
    
  end
  factory :fga do
    
  end
  factory :score do
    
  end
  factory :playercondition do
    
  end
  factory :player do
    
  end
  factory :totalcondition do
    
  end
  factory :linescorecondition do
    
  end
  factory :total do
    
  end
  factory :linescore do
    
  end
  factory :team do
    
  end
  factory :venue do
    
  end
  factory :translation do
    
  end
  
  factory :user do
    name "Joe"
    email "test@test.com"
    #sequence(:email) { |n| "user_#{n}@factory.com" }
    password "123456"

    trait :admin do
      role 'admin'
    end
  end
  
  factory :users do
    name "Joe"
    sequence(:email) { |n| "user_#{n}@factory.com" }
    password "123456"
  end
  
end