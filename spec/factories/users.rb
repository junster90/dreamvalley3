FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today

    factory :staff do
      email { Faker::Name.first_name.downcase + "@mindvalley.com" }
    end

    factory :nonstaff do
      email { Faker::Name.first_name.downcase + "@gmail.com" }
    end
  end
end