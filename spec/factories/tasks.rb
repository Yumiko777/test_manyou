FactoryBot.define do
  factory :task do
    name { 'test_name1' }
    detail { 'test_detail1' }
    deadline { DateTime.now }
  end

  factory :second_task, class: Task do
    name { 'test_name2' }
    detail { 'test_detail2' }
    deadline { DateTime.tomorrow }
  end
end
