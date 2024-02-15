require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'POST /create' do
    let (:user_attrs) { FactoryBot.attributes_for(:user) }

    it 'with valid params' do
      user_attrs[:password] = user_attrs[:password_digest]
      user = User.create! user_attrs
      user_attrs.delete :password_digest
      user_attrs.delete :name

      post sessions_url, params: { user: user_attrs }

      expect(user.email).to eq user_attrs[:email]
    end
  end
end
