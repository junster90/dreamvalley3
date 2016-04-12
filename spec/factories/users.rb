FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    factory :staff do
      email { Faker::Name.first_name.downcase + "@mindvalley.com" }
    end

    factory :nonstaff do
      email { Faker::Name.first_name.downcase + "@gmail.com" }
    end
  end
end