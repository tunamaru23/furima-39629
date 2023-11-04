require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '「全ての情報が入力されていればユーザー登録できます' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが未入力では登録できません' do
        @user.nickname = '' # nicknameの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'メールアドレスが未入力では登録できません' do
        @user.email = ''  # emailの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'パスワードが未入力では登録できません' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワード（確認用）が未入力では登録できません' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it '名前（名）が未入力では登録できません' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it '名前（名）に半角文字が含まれていると登録できません' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name は全角で入力してください'
      end
      it '名前（姓）が未入力では登録できません' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name can't be blank"
      end
      it '名前（姓）に半角文字が含まれていると登録できません' do
        @user.family_name = 'sample'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Family name は全角で入力してください'
      end
      it '名前（名、カナ）が未入力では登録できません' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it '名前（名、カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できません' do
        @user.first_name_kana = 'かな文字1!'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kana は全角カタカナで入力してください'
      end
      it '名前（姓、カナ）が未入力では登録できません' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name kana can't be blank"
      end
      it '名前（姓、カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できません' do
        @user.family_name_kana = 'teも寺1!'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Family name kana は全角カタカナで入力してください'
      end
      it '生年月日が未入力では登録できません' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth day can't be blank"
      end
      it 'パスワードが6文字未満では登録できません' do
        @user.password = '92922'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'パスワードが英文字のみの場合は登録できません' do
        @user.password = 'sassaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
      end
      it 'パスワードが数字のみの場合は登録できません' do
        @user.password = '313222222'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
      end
      it 'パスワードに全角文字が含まれている場合は登録できません' do
        @user.password = 'password全角文字'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
      end
      it 'パスワードが129文字以上では登録できません' do
        @user.password = Faker::Internet.password(min_length: 130, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too long (maximum is 128 characters)'
      end
      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        @user.password = 'test11'
        @user.password_confirmation = 'test12'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'メールアドレスに@が含まれていないと登録できません' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it '重複したメールアドレスが存在する場合は登録できません' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
    end
  end
end
