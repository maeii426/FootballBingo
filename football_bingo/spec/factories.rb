FactoryBot.define do

  factory :user do
    sequence(:name)  {Faker::Name.name}
    sequence(:email) {Faker::Internet.unique.email}
    #sequence(:email) { |n| "user_#{n}@factory.com" }
    password Faker::Internet.password
    role 'user'

    factory :admin do
      role 'admin'
    # trait :admin do
    #   role 'admin'
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


  factory :game, class: 'game' do

    game_name "TAMU vs RICE"
    date Faker::Date.between(2.days.ago, Date.today)
    notify_by_email 0
    source "source"
    version "00001"
    generated "01/01/2019"
    hometeam "TAMU"
    visteam "RICE"
    state "ongoing"
    association :venue

    # association :users
    # association :players
    # association :scores
    # association :totals
    # association :fgas
    # association :drives
  end

  factory :game_user, class: 'game_user' do
    state "player"
  end

  factory :translation, class: 'translation' do
    tag 'penalty_yds'
    words 'Number of penalty yards'
  end

  factory :chip, class: 'chip' do
    argument '>'
    value 100

    factory :lower_chip do
      probablity 0.1
    end
    factory :low_chip do
      probablity 0.3
    end
    factory :median_chip do
      probablity 0.5
    end
    factory :high_chip do
      probablity 0.7
    end
    factory :higher_chip do
      probablity 0.9
    end
  end

  factory :card, class: 'card' do
  end

  factory :card_chip, class: 'card_chip' do
  end

  factory :drive, class: 'drive' do
    
  end

  factory :fga do
    
  end

  factory :score do
    
  end
  factory :playercondition do
    
  end
  factory :player do
    
  end

  factory :totalcondition, class: 'totalcondition' do
    value 10
  end

  factory :linescorecondition do
    
  end

  factory :total, class: 'total' do
    qtr "test"                  
    totoff_plays 123
    totoff_yards 456
    totoff_avg 423
  end

  factory :linescore do
    prds Faker::Number.between(0, 30)
    score Faker::Number.between(0, 99)
    line Faker::Lorem.sentence
  end

  factory :team0, class: 'team' do
    name "TAMU"
    nameid "TAMU"
  end

  factory :team1, class: 'team' do
    name "RICE"
    nameid "RICE"
  end

  factory :venues do
    location Faker::Address.city
    sequence(:gameid) { |n| "#{n}" }
    attend Faker::Number.between(5000, 10000)
    date Faker::Date.between(2.days.ago, Date.today)
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