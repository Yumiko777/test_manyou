require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(name: '', detail: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'detailが空ならバリデーションが通らない' do
    task = Task.new(name: '失敗テスト', detail: '')
    expect(task).not_to be_valid
  end

  it 'nameとdetailに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '成功テスト', detail: '成功テスト', deadline: DateTime.now , status: 0, priority: 1)
    expect(task).to be_valid
  end

  before do
    @task = FactoryBot.create(:task)
  end

  it 'search_name実行時にタイトルが一致した場合' do
    expect(Task.search_name('test_name1')).to include(@task)
  end

  it 'search_name実行時にタイトルのデータが存在しない場合' do
    expect(Task.search_name('失敗テスト')).not_to include(@task)
  end

  it 'search_name実行時にステータスに完了を選択した場合' do
    expect(Task.search_status(2)).to include(@task)
  end
end
