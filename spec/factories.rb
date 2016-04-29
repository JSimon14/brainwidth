FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "fakeEmail#{n}@yahoo.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
    
  end
end