require 'rails_helper'

RSpec.describe Booking, type: :request do
  before(:each) do
    @user = User.create(name: 'username', email: 'username@email.com', password: 'password', role: 'admin')
    post '/api/v1/auth/login', params: {
      name: 'username',
      password: 'password'
    }.to_json
    json = JSON.parse(response.body).with_indifferent_access
    @token = json['token']
    @vehicle = Vehicle.create(model: 'vehicle_model', price: 12_345)
    @booking = @vehicle.bookings.create(start_date: '2022-10-02', end_date: '2022-11-14', city: 'Paris',
                                        user_id: @user.id)
  end

  describe 'GET api/v1/vehicles/:vehicle_id/bookings' do
    it 'invalid without authorization' do
      get "/api/v1/vehicles/#{@vehicle.id}/bookings"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET api/v1/vehicles/:vehicle_id/bookings' do
    before(:each) do
      get "/api/v1/vehicles/#{@vehicle.id}/bookings", headers: { Authorization: @token }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with booking data' do
      json = JSON.parse(response.body)[0].with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json.keys).to match_array(%w[id start_date end_date city user_id vehicle_id created_at updated_at])
    end
  end

  describe 'GET api/v1/vehicles/:vehicle_id/bookings' do
    before(:each) do
      get '/api/v1/vehicles/0/bookings', headers: { Authorization: @token }
    end

    it 'invalid with invalid vehicle id' do
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET api/v1/vehicles/:vehicle_id/bookings/:id' do
    it 'invalid without authorization' do
      get "/api/v1/vehicles/#{@vehicle.id}/bookings/#{@booking.id}"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET api/v1/vehicles/:vehicle_id/bookings/:id' do
    before(:each) do
      get "/api/v1/vehicles/#{@vehicle.id}/bookings/#{@booking.id}", headers: { Authorization: @token }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with booking data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to eq(@booking.id)
      expect(json['start_date']).to eq('2022-10-02')
      expect(json['end_date']).to eq('2022-11-14')
      expect(json['city']).to eq('Paris')
      expect(json['vehicle_id']).to eq(@vehicle.id)
      expect(json['user_id']).to eq(@user.id)
      expect(json.keys).to match_array(%w[id start_date end_date city vehicle_id user_id created_at updated_at])
    end
  end

  describe 'GET api/v1/vehicles/:vehicle_id/bookings/:id' do
    it 'invalid without a valid vehicle' do
      get "/api/v1/vehicles/0/bookings/#{@booking.id}", headers: { Authorization: @token }
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET api/v1/vehicles/:vehicle_id/bookings/:id' do
    it 'invalid without a valid booking' do
      get "/api/v1/vehicles/#{@vehicle.id}/bookings/0", headers: { Authorization: @token }
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/bookings' do
    it 'invalid without authorization' do
      post "/api/v1/vehicles/#{@vehicle.id}/bookings", params: {
        start_date: '2022-10-21',
        end_date: '2022-10-25',
        city: 'Berlin',
        user_id: @user.id
      }.to_json
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/bookings' do
    before(:each) do
      post "/api/v1/vehicles/#{@vehicle.id}/bookings", params: {
        start_date: '2022-10-21',
        end_date: '2022-10-25',
        city: 'Berlin',
        user_id: @user.id
      }.to_json, headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with booking data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['start_date']).to eq('2022-10-21')
      expect(json['end_date']).to eq('2022-10-25')
      expect(json['city']).to eq('Berlin')
      expect(json['vehicle_id']).to eq(@vehicle.id)
      expect(json['user_id']).to eq(@user.id)
      expect(json.keys).to match_array(%w[id start_date end_date city vehicle_id user_id created_at updated_at])
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/bookings' do
    it 'invalid without body parameters' do
      post "/api/v1/vehicles/#{@vehicle.id}/bookings", params: {}.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/bookings' do
    it 'invalid with invalid body parameters' do
      post "/api/v1/vehicles/#{@vehicle.id}/bookings", params: {
        account: 'banana'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/bookings' do
    it 'invalid without start_date parameter' do
      post "/api/v1/vehicles/#{@vehicle.id}/bookings", params: {
        end_date: '2022-10-25',
        city: 'Berlin',
        user_id: @user.id
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/bookings' do
    it 'invalid without end_date parameter' do
      post "/api/v1/vehicles/#{@vehicle.id}/bookings", params: {
        start_date: '2022-10-21',
        city: 'Berlin',
        user_id: @user.id
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/bookings' do
    it 'invalid without city parameter' do
      post "/api/v1/vehicles/#{@vehicle.id}/bookings", params: {
        start_date: '2022-10-21',
        end_date: '2022-10-25',
        user_id: @user.id
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/bookings' do
    it 'invalid without user_id parameter' do
      post "/api/v1/vehicles/#{@vehicle.id}/bookings", params: {
        start_date: '2022-10-21',
        end_date: '2022-10-25',
        city: 'Berlin'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

RSpec.describe Booking, type: :request do
  before(:each) do
    @user = User.create(name: 'username', email: 'username@email.com', password: 'password', role: 'admin')
    post '/api/v1/auth/login', params: {
      name: 'username',
      password: 'password'
    }.to_json
    json = JSON.parse(response.body).with_indifferent_access
    @token = json['token']
    @vehicle = Vehicle.create(model: 'vehicle_model', price: 12_345)
    @booking = @vehicle.bookings.create(start_date: '2022-10-02', end_date: '2022-11-14', city: 'Paris',
                                        user_id: @user.id)
  end

  describe 'GET api/v1/users/:user_id/bookings' do
    it 'invalid without authorization' do
      get "/api/v1/users/#{@user.id}/bookings"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET api/v1/users/:user_id/bookings' do
    before(:each) do
      get "/api/v1/users/#{@user.id}/bookings", headers: { Authorization: @token }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with booking data' do
      json = JSON.parse(response.body)[0].with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json.keys).to match_array(%w[id start_date end_date city user_id vehicle_id created_at updated_at])
    end
  end

  describe 'GET api/v1/users/:user_id/bookings' do
    before(:each) do
      get '/api/v1/users/0/bookings', headers: { Authorization: @token }
    end

    it 'invalid with invalid user id' do
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET api/v1/users/:user_id/bookings/:id' do
    it 'invalid without authorization' do
      get "/api/v1/users/#{@user.id}/bookings/#{@booking.id}"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET api/v1/users/:user_id/bookings/:id' do
    before(:each) do
      get "/api/v1/users/#{@user.id}/bookings/#{@booking.id}", headers: { Authorization: @token }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with booking data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to eq(@booking.id)
      expect(json['start_date']).to eq('2022-10-02')
      expect(json['end_date']).to eq('2022-11-14')
      expect(json['city']).to eq('Paris')
      expect(json['vehicle_id']).to eq(@vehicle.id)
      expect(json['user_id']).to eq(@user.id)
      expect(json.keys).to match_array(%w[id start_date end_date city vehicle_id user_id created_at updated_at])
    end
  end

  describe 'GET api/v1/users/:user_id/bookings/:id' do
    it 'invalid without a valid user' do
      get "/api/v1/users/0/bookings/#{@booking.id}", headers: { Authorization: @token }
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET api/v1/users/:user_id/bookings/:id' do
    it 'invalid without a valid booking' do
      get "/api/v1/users/#{@user.id}/bookings/0", headers: { Authorization: @token }
      expect(response.status).to eq(404)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST api/v1/users/:user_id/bookings' do
    it 'invalid without authorization' do
      post "/api/v1/users/#{@user.id}/bookings", params: {
        start_date: '2022-10-21',
        end_date: '2022-10-25',
        city: 'Berlin',
        vehicle_id: @vehicle.id
      }.to_json
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST api/v1/users/:user_id/bookings' do
    before(:each) do
      post "/api/v1/users/#{@user.id}/bookings", params: {
        start_date: '2022-10-21',
        end_date: '2022-10-25',
        city: 'Berlin',
        vehicle_id: @vehicle.id
      }.to_json, headers: {
        Authorization: @token
      }
    end

    it 'valid with authorization' do
      expect(response.status).to eq(200)
      expect(response).to have_http_status(:success)
    end

    it 'return json file with booking data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['start_date']).to eq('2022-10-21')
      expect(json['end_date']).to eq('2022-10-25')
      expect(json['city']).to eq('Berlin')
      expect(json['vehicle_id']).to eq(@vehicle.id)
      expect(json['user_id']).to eq(@user.id)
      expect(json.keys).to match_array(%w[id start_date end_date city vehicle_id user_id created_at updated_at])
    end
  end

  describe 'POST api/v1/users/:user_id/bookings' do
    it 'invalid without body parameters' do
      post "/api/v1/users/#{@user.id}/bookings", params: {}.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/users/:user_id/bookings' do
    it 'invalid with invalid body parameters' do
      post "/api/v1/users/#{@user.id}/bookings", params: {
        account: 'banana'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Empty body. Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/users/:user_id/bookings' do
    it 'invalid without start_date parameter' do
      post "/api/v1/users/#{@user.id}/bookings", params: {
        end_date: '2022-10-25',
        city: 'Berlin',
        vehicle_id: @vehicle.id
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/users/:user_id/bookings' do
    it 'invalid without end_date parameter' do
      post "/api/v1/users/#{@user.id}/bookings", params: {
        start_date: '2022-10-21',
        city: 'Berlin',
        vehicle_id: @vehicle.id
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/users/:user_id/bookings' do
    it 'invalid without city parameter' do
      post "/api/v1/users/#{@user.id}/bookings", params: {
        start_date: '2022-10-21',
        end_date: '2022-10-25',
        vehicle_id: @vehicle.id
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST api/v1/users/:user_id/bookings' do
    it 'invalid without vehicle_id parameter' do
      post "/api/v1/users/#{@user.id}/bookings", params: {
        start_date: '2022-10-21',
        end_date: '2022-10-25',
        city: 'Berlin'
      }.to_json, headers: {
        Authorization: @token
      }
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['error']).to eq('Could not create booking.')
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
