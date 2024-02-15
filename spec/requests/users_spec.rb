require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'POST /create' do
    let (:user_attrs) { FactoryBot.attributes_for(:user) }

    it 'without password says Can\'be blank' do
      user_attrs.delete(:password_digest) # Abstraction of password
      post users_url, params: { user: user_attrs }

      expect(document.body).to match_text 'Password can\'t be blank'
    end

    it 'without email says Can\'be blank' do
      user_attrs[:password] = user_attrs[:password_digest]
      user_attrs.delete(:email)
      post users_url, params: { user: user_attrs }

      expect(document.body).to match_text 'Email can\'t be blank'
    end

    it 'without name says Can\'be blank' do
      user_attrs[:password] = user_attrs[:password_digest]
      user_attrs.delete(:name)
      post users_url, params: { user: user_attrs }

      expect(document.body).to match_text 'Name can\'t be blank'
    end

    it 'with valid params' do
      user_attrs[:password] = user_attrs[:password_digest]
      post users_url, params: { user: user_attrs }

      expect(User.find_by_email(user_attrs[:email]).email).to eq user_attrs[:email]
    end
  end
end
