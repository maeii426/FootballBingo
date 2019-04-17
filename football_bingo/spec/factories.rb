FactoryBot.define do

  factory :user do
    name Faker::Name.name
    email Faker::Internet.unique.email
    #sequence(:email) { |n| "user_#{n}@factory.com" }
    password Faker::Internet.password

    trait :admin do
      role 'admin'
    end
  end

  factory :venue do
    location Faker::Address.city
    sequence(:gameid) { |n| "#{n}" }
    attend Faker::Number.between(5000, 10000)
    date Faker::Date.between(2.days.ago, Date.today)
  end

  # factory :users do
  #   name {Faker::Name.unique.name}
  #   # sequence(:email) { |n| "user_#{n}@factory.com" }
  #   email { Faker::Internet.unique.email }
  #   password {Faker::Internet.password}
  #   trait :users do
  #     role 'user'
  #   end  
  # end


  factory :game, class: Game do

    game_name "testgamename"
    date Faker::Date.between(2.days.ago, Date.today)
    instant_winner "instant_winner"
    whoop_winner "whoop_winner"
    notify_by_email 0
    source "source"
    version "00001"
    generated "01/01/2019"
    hometeam "TAMU"
    visteam "RICE"
    association :venue
    # association :users
    # association :players
    # association :scores
    # association :totals
    # association :fgas
    # association :drives
  end

  factory :drive, class: 'Drive' do
    
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
    prds Faker::Number.between(0, 30)
    score Faker::Number.between(0, 99)
    line Faker::Lorem.sentence
  end

  factory :team0 do
    name Faker::Team.sport
    nameid Faker::Team.sport
  end

  factory :team1 do
    name Faker::Team.sport
    nameid Faker::Team.sport
  end

  factory :venues do
    location Faker::Address.city
    sequence(:gameid) { |n| "#{n}" }
    attend Faker::Number.between(5000, 10000)
    date Faker::Date.between(2.days.ago, Date.today)
  end

  factory :translation do
    
  end

  
  factory :linescores0 do
    prds Faker::Number.between(0, 30)
    score Faker::Number.between(0, 99)
    line Faker::Lorem.sentence
    association :game
    association :team0
  end

  factory :linescores1 do
    prds Faker::Number.between(0, 30)
    score Faker::Number.between(0, 99)
    line Faker::Lorem.sentence
    association :game
    association :team1
  end
end