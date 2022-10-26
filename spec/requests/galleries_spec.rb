require 'rails_helper'

RSpec.describe Gallery, type: :request do
  before(:each) do
    User.create(name: 'username', email: 'username@email.com', password: 'password', role: 'admin')
    post '/api/v1/auth/login', params: {
      name: 'username',
      password: 'password'
    }.to_json
    json = JSON.parse(response.body).with_indifferent_access
    @token = json['token']
    @vehicle = Vehicle.create(model: 'vehicle_model', price: 12_345)
    @vehicle.galleries.create(photo: 'photo.jpg')
  end

  describe 'GET api/v1/vehicles/:vehicle_id/galleries' do
    it 'invalid without authorization' do
      get "/api/v1/vehicles/#{@vehicle.id}/galleries"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET api/v1/vehicles/:vehicle_id/galleries' do
    before(:each) do
      get "/api/v1/vehicles/#{@vehicle.id}/galleries", headers: { Authorization: @token }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with gallery data' do
      json = JSON.parse(response.body)[0].with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json.keys).to match_array(%w[id photo vehicle])
    end
  end

  describe 'GET api/v1/vehicles/:vehicle_id/galleries' do
    before(:each) do
      get '/api/v1/vehicles/0/galleries', headers: { Authorization: @token }
    end

    it 'invalid with invalid vehicle id' do
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    it 'invalid without authorization' do
      post "/api/v1/vehicles/#{@vehicle.id}/galleries", params: {
        name: 'new_galleryname',
        password: 'new_password',
        email: 'new_galleryname@email.com'
      }.to_json
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    before(:each) do
      post "/api/v1/vehicles/#{@vehicle.id}/galleries", params: {
        photo: 'photo.png'
      }.to_json, headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with gallery data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['photo']).to eq('photo.png')
      expect(json.keys).to match_array(%w[id photo vehicle])
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    it 'invalid without body parameters' do
      post "/api/v1/vehicles/#{@vehicle.id}/galleries", params: {}.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create gallery.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    it 'invalid with invalid body parameters' do
      post "/api/v1/vehicles/#{@vehicle.id}/galleries", params: {
        account: 'banana'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create gallery.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    it 'invalid without photo parameter' do
      post "/api/v1/vehicles/#{@vehicle.id}/galleries", params: { vehicle_id: @vehicle.id }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create gallery.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
