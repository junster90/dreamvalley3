FactoryGirl.define do
  factory :goal do
    sequence :description do |n|
      "Goal#{n}"
    end
    category Goal.category.values.sample
    user User.first
  end
end