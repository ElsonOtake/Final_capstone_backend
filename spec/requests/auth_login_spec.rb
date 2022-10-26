require 'rails_helper'

RSpec.describe User, type: :request do
  before(:each) do
    user = User.create(name: 'username', email: 'username@email.com', password: 'password', role: 'admin')
    @id = user.id
  end

  describe 'POST api/v1/auth/login' do
    it 'return error with blank parameters' do
      post '/api/v1/auth/login', params: {}.to_json
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['errors']).to eq('Username not found')
    end

    it 'valid with correct parameters' do
      post '/api/v1/auth/login', params: {
        name: 'username',
        password: 'password'
      }.to_json
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
      expect(json.keys).to match_array(%w[token exp name role id])
      expect(json['name']).to eq('username')
    end

    it 'invalid with incorrect values' do
      post '/api/v1/auth/login', params: {
        name: 'banana',
        password: 'cucumber'
      }.to_json
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['errors']).to eq('Username not found')
    end

    it 'invalid with incorrect parameters' do
      post '/api/v1/auth/login', params: {
        account: 'account',
        address: 'address'
      }.to_json
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['errors']).to eq('Username not found')
    end

    it 'invalid without password' do
      post '/api/v1/auth/login', params: {
        name: 'username'
      }.to_json
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Unauthorized')
    end
  end
end
