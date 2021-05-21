require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    FactoryBot.create(:task, name: 'task1')
    FactoryBot.create(:second_task , name: 'task2')
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in :name, with: 'task1'
        click_on '検索'
        expect(page).to have_content 'task1'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '完了', from: :status
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in :name, with: 'task2'
        select '着手中', from: :status
        click_on '検索'
        expect(page).to have_content 'task2'
        expect(page).to have_content '着手中'
      end
    end
  end

  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_name, with: 'task1'
        fill_in :task_detail, with: 'task1'
        fill_in :task_deadline, with: '002021-12-31'
        select '着手中', from: :task_status
        select '中', from: :task_priority
        click_on '登録する'
        expect(page).to have_content 'task2'
        expect(page).to have_content '着手中'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'name'
      end
    end
  end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test_name2'
        expect(task_list[1]).to have_content 'test_name1'
      end
    end

    context '終了期限でソートした場合' do
      it 'タスクが終了期限順に並んでいる' do
        visit tasks_path
        click_on '終了期限でソートする' , match: :first
        task_list = all('.task_row_deadline')
        #binding.pry
        expect(task_list[1]).to have_content '2021-05-22'
        expect(task_list[3]).to have_content '2021-05-21'
      end
    end

     context '優先度高い順でソートした場合' do
       it 'タスクが優先度順に並んでいる' do
         visit tasks_path
         click_on '優先度高い順でソートする', match: :first
         task_list = all('.task_row_priority')
         #binding.pry
         expect(task_list[1]).to have_content '中'
         expect(task_list[3]).to have_content '低'
       end
     end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit tasks_path
         expect(page).to have_content 'name'
       end
     end
  end
end
