FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'test_user1' }
    email { 'test_user1@test.com' }
    password { '12345678' }
    admin { false }
  end
  factory :second_user, class: User do
    id { 2 }
    name { 'test_user2' }
    email { 'test_user2@test.com' }
    password { '87654321' }
    admin { true }
  end
end
