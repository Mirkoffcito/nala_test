FactoryBot.define do
  factory :employee, class: Employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end