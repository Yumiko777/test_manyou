FactoryBot.define do
  factory :task do
    name { 'test_name１' }
    detail { 'test_detail１' }
  end

  factory :second_task, class: Task do
    name { 'test_name２' }
    detail { 'test_detail２' }
  end
end
