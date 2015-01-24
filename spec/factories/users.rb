FactoryGirl.define do
  factory :user do
    sequence :login do |n|
      "person#{n}@example.com"
    end
    
    password SecureRandom.base64
    permission 2
    trait :admin do
      permission 4
    end
    
    trait :coach do
      permission 3
    end
    
    trait :locked do
      permission 1
    end
  end
end
