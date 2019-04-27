FactoryBot.define do

  factory :user, class: 'user' do
    sequence(:name)  { Faker::Name.name }
    sequence(:email) { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    role 'user'

    trait :admin do
      role 'admin'
    end
  end

  factory :venue, class: 'venue' do
    location { Faker::Address.city }
    sequence(:gameid) { |n| "#{n}" }
    attend { Faker::Number.between(5000, 10000) }
    date { Faker::Date.between(2.days.ago, Date.today) }
    game
  end

  factory :team, class: 'team' do
    name { Faker::University.name }
    nameid { Faker::University.name }

    trait :tamu do
      name "TAMU"
      nameid "TAMU"
    end

    trait :rice do
      name "RICE"
      nameid "RICE"
    end
  end

  factory :game, class: 'game' do   
    notify_by_email 0
    source "source"
    version "00001"
    generated "01/01/2019"
    hometeam "TAMU"
    visteam "RICE"
    game_name {"#{hometeam} vs #{visteam}"} # Dependent Attributes

    trait :is_ongoing do
      state "ongoing"
      date { Date.today }
    end

    trait :is_finished do
      state "finished"
      date { Faker::Date.between(1.month.ago, 1.day.ago) }
    end

    trait :is_upcoming do
      state "upcoming"
      date { Faker::Date.forward(60) }
    end 
  end

  factory :game_user, class: 'game_user' do
    game
    user

    trait :player do
      state "player"
    end

    trait :instant_winner do
      state "instant_winner"
    end

    trait :whoop_winner do
      state "whoop_winner"
    end
  end

  factory :card, class: 'card' do
    user
    game
  end

  factory :chip, class: 'chip' do
    argument '>'
    value { Faker::Number.between(0, 100) }
    game
    translation

    trait :lower do
      probablity 0.1
    end

    trait :low do
      probablity 0.3
    end

    trait :median do
      probablity 0.5
    end

    trait :high do
      probablity 0.7
    end

    trait :higher do
      probablity 0.9
    end
  end

  factory :card_chip, class: 'card_chip' do
    card
    chip
  end

  factory :total, class: 'total' do
    qtr "test"                  
    totoff_plays { Faker::Number.between(0, 150) }
    totoff_yards { Faker::Number.between(0, 500) }
    totoff_avg { Faker::Number.between(0, 300) }
    game
    team
  end

  factory :translation, class: 'translation' do

    trait :penalty_yds do
      tag 'penalty_yds'
      words 'Number of penalty yards'
    end

    trait :firstdowns_no do
      tag 'firstdowns_no'
      words 'Total first downs'
    end
  end

  factory :totalcondition, class: 'totalcondition' do
    value { Faker::Number.between(0, 30) }
    total
    translation
  end

  factory :score, class: 'score' do
    game
    team
  end

  factory :playercondition, class: 'playercondition' do
    playercondition
    translation
  end

  factory :player, class: 'player' do
    game
    team
  end

  factory :drife, class: 'drife' do # not a typo
    game
    team
  end

  factory :fga, class: 'fga' do
    game
    team
  end

  factory :linescorecondition, class: 'linescorecondition' do
    linescorecondition
    translation
  end

  factory :linescore, class: 'linescore' do
    prds { Faker::Number.between(0, 30) }
    score { Faker::Number.between(0, 99) }
    line { Faker::Lorem.sentence }
    game
    team
  end

end
