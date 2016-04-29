FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "fakeEmail#{n}@yahoo.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
    
  end

  factory :task do
    title 'hello'
    date 'April 27 2016' 
    value '2' 
    category 'work'
    association :user
  end

end