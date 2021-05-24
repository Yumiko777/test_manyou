require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session_email', with:'test_user1@test.com'
    fill_in 'session_password', with:'12345678'
    click_on 'Log in'
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
    visit tasks_path
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in :name, with: 'test_name1'
        click_on '検索'
        expect(page).to have_content 'test_name1'
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
        fill_in :name, with: 'test_name2'
        select '着手中', from: :status
        click_on '検索'
        expect(page).to have_content 'test_name2'
        expect(page).to have_content '着手中'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_name, with: 'test_name1'
        fill_in :task_detail, with: 'test_detail1'
        fill_in :task_deadline, with: '002021-12-31'
        select '着手中', from: :task_status
        select '中', from: :task_priority
        click_on '登録する'
        expect(page).to have_content 'test_name1'
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
        click_link '終了期限でソートする' , match: :first
        sleep 1
        task_list = all('.task_row_deadline')
        #binding.pry
        expect(task_list[0]).to have_content '2021-05-25'
        expect(task_list[1]).to have_content '2021-05-24'
      end
    end

     context '優先度高い順でソートした場合' do
       it 'タスクが優先度順に並んでいる' do
         visit tasks_path
         click_on '優先度高い順でソートする', match: :first
         sleep 1
         task_list = all('.task_row_priority')
         #binding.pry
         expect(task_list[0]).to have_content '中'
         expect(task_list[1]).to have_content '低'
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
