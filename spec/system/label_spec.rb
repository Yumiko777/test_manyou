require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do

  before do
    @user = FactoryBot.create(:user)
    @label = FactoryBot.create(:label)
    visit new_session_path
    fill_in 'session_email', with:'test_user1@test.com'
    fill_in 'session_password', with:'12345678'
    click_on 'Log in'
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
  end

  describe 'ラベル管理' do
    context'ラベルを作成した場合' do
      it 'ラベルが作成できる' do
      visit new_label_path
      fill_in  "label_name" , with: "松"
      click_on '登録する'
      expect(page).to have_content "松"
      end
    end

    context'タスクにラベルが付けられる' do
        it 'タスクを新規作成' do
        visit new_task_path
        fill_in :task_name , with: 'test_name1'
        fill_in :task_detail , with: 'test_detail1'
        fill_in :task_deadline , with: '002021-12-31'
        select '着手中', from: :task_status
        select '中', from: :task_priority
        check 'task[label_ids][]'
        click_on "登録する"
        end
      end

    context 'ラベルで絞り込んで検索した場合' do
      it 'ラベルで検索が絞り込まれる' do
        visit tasks_path
        select '松', from: :label_id
        click_on '検索'
        expect(page).to have_content '松'
      end
    end
  end
end
