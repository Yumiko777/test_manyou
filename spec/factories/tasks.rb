FactoryBot.define do
  factory :task do
    name { 'test_name1' }
    detail { 'test_detail1' }
  end

  factory :second_task, class: Task do
    name { 'test_name2' }
    detail { 'test_detail2' }
  end
end
