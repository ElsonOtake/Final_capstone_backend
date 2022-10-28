require 'rails_helper'

RSpec.describe User, type: :request do
  before(:each) do
    @user = User.create(name: 'user', email: 'user@email.com', password: 'password')
    post '/api/v1/auth/login', params: {
      name: 'user',
      password: 'password'
    }.to_json
    json = JSON.parse(response.body).with_indifferent_access
    @token = json['token']
    @admin = User.create(name: 'admin', email: 'admin@email.com', password: 'password', role: 'admin')
    post '/api/v1/auth/login', params: {
      name: 'admin',
      password: 'password'
    }.to_json
    json_admin = JSON.parse(response.body).with_indifferent_access
    @token_admin = json_admin['token']
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
      get "/api/v1/users/#{@user.id}"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET api/v1/users/:id' do
    before(:each) do
      get "/api/v1/users/#{@user.id}", headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with user data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to eq(@user.id)
      expect(json['name']).to eq('user')
      expect(json['email']).to eq('user@email.com')
      expect(json.keys).to match_array(%w[id name created_at updated_at email role])
    end
  end

  describe 'GET api/v1/users/:id' do
    it 'invalid without a valid user' do
      get '/api/v1/users/0', headers: {
        Authorization: @token
      }
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
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
    it 'invalid without authorization' do
      put "/api/v1/users/#{@user.id}", params: {
        name: 'rename_username',
        password: 'rename_password',
        email: 'rename_username@email.com',
        role: 'admin'
      }.to_json
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PUT api/v1/users/:id' do
    it 'invalid with authorization for regular users' do
      put "/api/v1/users/#{@user.id}", params: {
        name: 'rename_username',
        password: 'rename_password',
        email: 'rename_username@email.com',
        role: 'admin'
      }.to_json, headers: {
        Authorization: @token
      }
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PUT api/v1/users/:id' do
    before(:each) do
      put "/api/v1/users/#{@user.id}", params: {
        name: 'rename_username',
        password: 'rename_password',
        email: 'rename_username@email.com',
        role: 'admin'
      }.to_json, headers: {
        Authorization: @token_admin
      }
    end

    it 'valid with authorization for admin users' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with user data for admin users' do
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
      put "/api/v1/users/#{@user.id}", params: {
        role: 'admin'
      }.to_json, headers: {
        Authorization: @token_admin
      }
    end

    it 'valid with authorization for admin users' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with partial user data for admin users' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['role']).to eq('admin')
      expect(json.keys).to match_array(%w[id name created_at updated_at email role])
    end
  end

  describe 'PUT api/v1/users/:id' do
    it 'invalid without body parameters for admin users' do
      put "/api/v1/users/#{@user.id}", params: {}.to_json, headers: {
        Authorization: @token_admin
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not update user.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT api/v1/users/:id' do
    it 'invalid with invalid body parameters for admin users' do
      put "/api/v1/users/#{@user.id}", params: {
        account: 'banana'
      }.to_json, headers: {
        Authorization: @token_admin
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not update user.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE api/v1/users/:id' do
    it 'invalid without authorization' do
      delete "/api/v1/users/#{@user.id}"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE api/v1/users/:id' do
    it 'valid with authorization for admin users' do
      other = User.create(name: 'other', email: 'other@email.com', password: 'otherpassword')
      delete "/api/v1/users/#{other.id}", headers: {
        Authorization: @token_admin
      }
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE api/v1/users/:id' do
    it 'invalid with authorization for regular users' do
      other = User.create(name: 'other', email: 'other@email.com', password: 'otherpassword')
      delete "/api/v1/users/#{other.id}", headers: {
        Authorization: @token
      }
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE api/v1/users/:id' do
    it 'invalid without valid user' do
      delete '/api/v1/users/0', headers: {
        Authorization: @token_admin
      }
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end
end
