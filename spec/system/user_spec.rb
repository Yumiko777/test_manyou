require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能・管理画面テスト', type: :system do

  describe 'ユーザ登録のテスト' do
    context 'ユーザ登録がなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user_name', with: 'test_user1'
        fill_in 'user_email', with: 'test_user1@test.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_on 'アカウントを作成する'
        expect(page).to have_content 'test_user1'
      end
      it '​ログインしていない時はログイン画面に飛ぶテスト​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'session機能テスト' do
    before do
      @user = FactoryBot.create(:user)
      @second_user = FactoryBot.create(:second_user)
    end

    context "ログインしていない状態でユーザデータがある場合" do
      it 'ログインができること' do
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_on "Log in"
        expect(current_path).to eq user_path(id: @user.id)
      end
    end

    context 'ログインしている場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_on "Log in"
      end

      it '自分の詳細画面に飛べること' do
        visit user_path(id: @user.id)
        expect(current_path).to eq user_path(id: @user.id)
      end

      it "一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
        visit user_path(2)
        expect(page).to have_content "権限がありません。ログインしてください!"
      end

      it "ログイン画面に戻る" do
        visit user_path(id: @user.id)
        click_on "Logout"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe "管理画面のテスト" do
    context "管理ユーザ作成" do
      it "管理者は管理画面にアクセスできること" do
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in "session_email", with: "test_user2@test.com​"
        fill_in "session_password", with: "87654321"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "管理画面のユーザー一覧画面"
      end
    end

    context "一般ユーザーがログインしている場合" do
      it "一般ユーザーは管理画面にはアクセスできない" do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in "session_email", with: "test_user1@test.com​"
        fill_in "session_password", with: "12345678"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "あなたは管理者ではありません"
      end
    end

    context "管理者でログインしている場合" do
      before do
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in "session_email", with: "test_user2@test.com​"
        fill_in "session_password", with: "87654321"
        click_on "Log in"
        visit admin_users_path
      end

      it "管理者はユーザ新規登録ができる" do
        click_link "新規ユーザー作成"
        #binding.pry
        fill_in "user_name", with: 'test_user2'
        fill_in "user_email", with: 'test_user2@test.com'
        fill_in "user_password", with: '87654321'
        fill_in "user_password_confirmation", with: '87654321'
        click_on "登録する"
        expect(page).to have_content 'test_user2'
      end

      it "管理者はユーザの詳細画面へアクセスできる" do
        @user = FactoryBot.create(:user)
        visit admin_user_path(id: @user.id)
        expect(page).to have_content "test_user1"
      end

      it "管理者ユーザーの編集画面からユーザーの編集ができる" do
        @user = FactoryBot.create(:user)
        visit edit_admin_user_path(id: @user.id)
        fill_in 'user_name', with: 'test_user1'
        fill_in 'user_email', with: 'test_user1@test.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_on '更新する'
        expect(page).to have_content "test_user1"
      end

      it "管理者はユーザーを削除できる" do
        @user = FactoryBot.create(:user)
        visit admin_users_path
        click_on "削除", match: :first
      end
    end
  end
end
