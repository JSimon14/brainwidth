FactoryGirl.define do
  factory :category do
    name 'school'
  end

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
    association :user
  end


end