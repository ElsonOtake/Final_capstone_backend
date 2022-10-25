require 'rails_helper'

RSpec.describe User, type: :request do
  before(:each) do
    user = User.create(name: 'username', email: 'username@email.com', password: 'password', role: 'admin')
    @id = user.id
    post '/api/v1/auth/login', params: {
      name: 'username',
      password: 'password'
    }.to_json
    json = JSON.parse(response.body).with_indifferent_access
    @token = json['token']
  end

  describe 'GET api/v1/users' do
    it 'valid with authorization' do
      get '/api/v1/users', headers: { Authorization: @token }
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with user data' do
      get '/api/v1/users', headers: { Authorization: @token }
      json = JSON.parse(response.body)[0].with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['name']).to eq('username')
      expect(json['email']).to eq('username@email.com')
      expect(json['role']).to eq('admin')
      expect(json.keys).to match_array(%w[id name created_at updated_at email role])
    end
  end

# describe 'GET api/v1/users/:id' do
#   it 'invalid without authorization' do
#     get "/api/v1/users/#{@id}", headers: { Authorization: @token }
#     json = JSON.parse(response.body).with_indifferent_access
#     p response.body
#     expect(json['errors']).to eq('Unauthorized user')
#   end
end
