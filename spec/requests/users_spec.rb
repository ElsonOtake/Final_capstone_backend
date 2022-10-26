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
    it 'valid without authorization' do
      get '/api/v1/users'
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET api/v1/users' do
    before(:each) do
      get '/api/v1/users', headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with user data' do
      json = JSON.parse(response.body)[0].with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json.keys).to match_array(%w[id name created_at updated_at email role])
    end
  end

  describe 'GET api/v1/users/:id' do
    it 'invalid without authorization' do
      get "/api/v1/users/#{@id}"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET api/v1/users/:id' do
    before(:each) do
      get "/api/v1/users/#{@id}", headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with user data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to eq(@id)
      expect(json['name']).to eq('username')
      expect(json['email']).to eq('username@email.com')
      expect(json['role']).to eq('admin')
      expect(json.keys).to match_array(%w[id name created_at updated_at email role])
    end
  end

  describe 'POST api/v1/users' do
    it 'valid without authorization' do
      post '/api/v1/users', params: {
        name: 'new_username',
        password: 'new_password',
        email: 'new_username@email.com'
      }.to_json
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST api/v1/users' do
    before(:each) do
      post '/api/v1/users', params: {
        name: 'new_username',
        password: 'new_password',
        email: 'new_username@email.com'
      }.to_json, headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with user data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['name']).to eq('new_username')
      expect(json['email']).to eq('new_username@email.com')
      expect(json.keys).to match_array(%w[id name created_at updated_at email role])
    end
  end

  describe 'POST api/v1/users' do
    it 'invalid without body parameters' do
      post '/api/v1/users', params: {}.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create user.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/users' do
    it 'invalid with invalid body parameters' do
      post '/api/v1/users', params: {
        account: 'banana'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create user.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/users' do
    it 'invalid without name parameter' do
      post '/api/v1/users', params: {
        email: 'new_username@email.com',
        password: 'new_password'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create user.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/users' do
    it 'invalid without password parameter' do
      post '/api/v1/users', params: {
        name: 'new_username',
        email: 'new_username@email.com'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create user.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/users' do
    it 'invalid without email parameter' do
      post '/api/v1/users', params: {
        name: 'new_username',
        password: 'new_password'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create user.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT api/v1/users/:id' do
    before(:each) do
      put "/api/v1/users/#{@id}", params: {
        name: 'rename_username',
        password: 'rename_password',
        email: 'rename_username@email.com',
        role: 'admin'
      }.to_json, headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with user data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['name']).to eq('rename_username')
      expect(json['email']).to eq('rename_username@email.com')
      expect(json['role']).to eq('admin')
      expect(json.keys).to match_array(%w[id name created_at updated_at email role])
    end
  end

  describe 'PUT api/v1/users/:id' do
    before(:each) do
      put "/api/v1/users/#{@id}", params: {
        role: 'admin'
      }.to_json, headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with partial user data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['role']).to eq('admin')
      expect(json.keys).to match_array(%w[id name created_at updated_at email role])
    end
  end

  describe 'PUT api/v1/users/:id' do
    it 'invalid without body parameters' do
      put "/api/v1/users/#{@id}", params: {}.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not update user.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT api/v1/users/:id' do
    it 'invalid with invalid body parameters' do
      put "/api/v1/users/#{@id}", params: {
        account: 'banana'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not update user.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE api/v1/users/:id' do
    it 'valid with authorization' do
      other = User.create(name: 'other', email: 'other@email.com', password: 'otherpassword')
      delete "/api/v1/users/#{other.id}", headers: {
        Authorization: @token
      }
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end
  end
end
