require 'rails_helper'

RSpec.describe Vehicle, type: :request do
  before(:each) do
    User.create(name: 'username', email: 'username@email.com', password: 'password', role: 'admin')
    post '/api/v1/auth/login', params: {
      name: 'username',
      password: 'password'
    }.to_json
    json = JSON.parse(response.body).with_indifferent_access
    @token = json['token']
    @vehicle = Vehicle.create(model: 'vehicle_model', description: 'vehicle_description', year: 'year',
                              brand: 'vehicle_brand', color: 'vehicle_color', country: 'vehicle_country',
                              power: 'num_HP', max_speed: 'num_km/h', acceleration: 'num s', price: 12_345)
  end

  describe 'GET api/v1/vehicles' do
    it 'invalid without authorization' do
      get '/api/v1/vehicles'
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET api/v1/vehicles' do
    before(:each) do
      get '/api/v1/vehicles', headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with vehicle data' do
      json = JSON.parse(response.body)[0].with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json.keys).to match_array(%w[id model description year brand color country power max_speed
                                          acceleration price galleries created_at updated_at])
    end
  end

  describe 'GET api/v1/vehicles/:id' do
    it 'invalid without authorization' do
      get "/api/v1/vehicles/#{@vehicle.id}"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET api/v1/vehicles/:id' do
    before(:each) do
      get "/api/v1/vehicles/#{@vehicle.id}", headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with vehicle data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to eq(@vehicle.id)
      expect(json['model']).to eq('vehicle_model')
      expect(json['description']).to eq('vehicle_description')
      expect(json['year']).to eq('year')
      expect(json['brand']).to eq('vehicle_brand')
      expect(json['color']).to eq('vehicle_color')
      expect(json['country']).to eq('vehicle_country')
      expect(json['power']).to eq('num_HP')
      expect(json['max_speed']).to eq('num_km/h')
      expect(json['acceleration']).to eq('num s')
      expect(json['price']).to eq(12_345)
      expect(json.keys).to match_array(%w[id model description year brand color country power max_speed
                                          acceleration price galleries created_at updated_at])
    end
  end

  describe 'GET api/v1/vehicles/:id' do
    it 'invalid without a valid vehicle' do
      get '/api/v1/vehicles/0', headers: {
        Authorization: @token
      }
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST api/v1/vehicles' do
    it 'invalid without authorization' do
      post '/api/v1/vehicles', params: {
        model: 'new_vehicle_model',
        price: 999
      }.to_json
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST api/v1/vehicles' do
    before(:each) do
      post '/api/v1/vehicles', params: {
        model: 'new_vehicle_model',
        price: 999
      }.to_json, headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with vehicle data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['model']).to eq('new_vehicle_model')
      expect(json['price']).to eq(999)
      expect(json.keys).to match_array(%w[id model description year brand color country power max_speed
                                          acceleration price galleries created_at updated_at])
    end
  end

  describe 'POST api/v1/vehicles' do
    it 'invalid without body parameters' do
      post '/api/v1/vehicles', params: {}.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create vehicle.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles' do
    it 'invalid with invalid body parameters' do
      post '/api/v1/vehicles', params: {
        name: 'banana'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create vehicle.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles' do
    it 'invalid without model parameter' do
      post '/api/v1/vehicles', params: {
        description: 'new_vehicle_description',
        price: 750
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create vehicle.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles' do
    it 'invalid without price parameter' do
      post '/api/v1/vehicles', params: {
        model: 'new_vehicle_model'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create vehicle.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE api/v1/vehicles/:id' do
    it 'invalid without authorization' do
      delete "/api/v1/vehicles/#{@vehicle.id}"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE api/v1/vehicles/:id' do
    it 'valid with authorization' do
      other = Vehicle.create(model:'other_model', price: 123)
      delete "/api/v1/vehicles/#{other.id}", headers: {
        Authorization: @token
      }
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE api/v1/vehicles/:id' do
    it 'invalid without valid vehicle' do
      delete '/api/v1/vehicles/0', headers: {
        Authorization: @token
      }
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end
end
