require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(name: 'Antonio', role: 'admin', email: 'antonio@mail.com', password: 'password')
  end

  context 'When testing User Class' do
    it 'Should have name' do
      expect(@user.name).to eq('Antonio')
    end

    it 'Name should be valid' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'Should have role' do
      expect(@user.role).to eq('admin')
    end

    it 'Should have email' do
      expect(@user.email).to eq('antonio@mail.com')
    end
  end

  describe 'email normalization' do
    it 'stores email in lowercase' do
      user = User.create(
        name: 'Antonio',
        email: 'ANTONIO@mail.com',
        password: 'password123'
      )

      expect(user.email).to eq('antonio@mail.com')
    end
  end

  describe 'email normalization with blank spaces' do
    it 'stores email in lowercase' do
      user = User.create(
        name: 'Antonio',
        email: ' ANTONIO@mail.com ',
        password: 'password123'
      )

      expect(user.email).to eq('antonio@mail.com')
    end
  end
end
