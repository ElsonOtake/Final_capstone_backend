require 'rails_helper'

RSpec.describe User, type: :request do
  before(:each) do
    user = User.create(name: 'username', email: 'username@email.com', password: 'password', role: 'admin')
    @id = user.id
  end

  describe 'POST api/v1/auth/login' do
    it 'returns unauthorized with blank parameters' do
      post '/api/v1/auth/login', params: {}.to_json
      json = JSON.parse(response.body).with_indifferent_access
      expect(response.status).to eq(401)
      expect(json['error']).to eq('Invalid email or password')
    end

    it 'valid with correct parameters' do
      post '/api/v1/auth/login', params: {
        email: 'username@email.com',
        password: 'password'
      }.to_json
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
      expect(json.keys).to match_array(%w[token exp name role id])
      expect(json['name']).to eq('username')
    end

    it 'returns unauthorized with an unknown email' do
      post '/api/v1/auth/login', params: {
        email: 'banana@avocado.com',
        password: 'cucumber'
      }.to_json
      json = JSON.parse(response.body).with_indifferent_access
      expect(response.status).to eq(401)
      expect(json['error']).to eq('Invalid email or password')
    end

    it 'returns unauthorized with a valid username but wrong password' do
      post '/api/v1/auth/login', params: {
        email: 'username@email.com',
        password: 'wrongpassword'
      }.to_json
      json = JSON.parse(response.body).with_indifferent_access
      expect(response.status).to eq(401)
      expect(json['error']).to eq('Invalid email or password')
    end

    it 'returns unauthorized with unrecognized parameters' do
      post '/api/v1/auth/login', params: {
        account: 'account',
        address: 'address'
      }.to_json
      json = JSON.parse(response.body).with_indifferent_access
      expect(response.status).to eq(401)
      expect(json['error']).to eq('Invalid email or password')
    end

    it 'returns unauthorized without a password' do
      post '/api/v1/auth/login', params: {
        email: 'username@email.com'
      }.to_json
      json = JSON.parse(response.body).with_indifferent_access
      expect(response.status).to eq(401)
      expect(json['error']).to eq('Invalid email or password')
    end
  end
end
