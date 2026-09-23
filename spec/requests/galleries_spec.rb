require 'rails_helper'

RSpec.describe Gallery, type: :request do
  before(:each) do
    User.create(name: 'visitor', email: 'visitor@email.com', password: 'password')
    post '/api/v1/auth/login', params: {
      name: 'visitor',
      password: 'password'
    }.to_json
    json = JSON.parse(response.body).with_indifferent_access
    @token = json['token']
    User.create(name: 'admin', email: 'admin@email.com', password: 'password', role: 'admin')
    post '/api/v1/auth/login', params: {
      name: 'admin',
      password: 'password'
    }.to_json
    json_admin = JSON.parse(response.body).with_indifferent_access
    @token_admin = json_admin['token']
    @vehicle = Vehicle.create(model: 'vehicle_model', price: 12_345)
    @gallery = @vehicle.galleries.build
    @gallery.photo_file.attach(
      io: File.open(Rails.root.join('spec/fixtures/files/car.jpg')),
      filename: 'car.jpg',
      content_type: 'image/jpeg'
    )
    @gallery.save!
  end

  describe 'GET api/v1/vehicles/:vehicle_id/galleries' do
    it 'invalid without authorization' do
      get "/api/v1/vehicles/#{@vehicle.id}/galleries"
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'invalid with a malformed token' do
      get '/api/v1/users/1', headers: {
        Authorization: 'Bearer not-a-real-token'
      }
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
      expect(json.keys).to match_array(%w[id photo vehicle_id])
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
      file = Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/files/car.jpg'), 'image/jpeg'
      )
      post "/api/v1/vehicles/#{@vehicle.id}/galleries", params: {
        photo_file: file
      }
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    before(:each) do
      file = Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/files/car.jpg'), 'image/jpeg'
      )

      post "/api/v1/vehicles/#{@vehicle.id}/galleries",
           params: { photo_file: file }, headers: { Authorization: @token_admin }
    end

    it 'valid with authorization for admin user' do
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it 'return json file with gallery data' do
      json = JSON.parse(response.body).with_indifferent_access
      expect(json['id']).to be_an(Integer)
      expect(json['photo']).to be_present
      expect(json['photo']).to include('car.jpg')
      expect(json.keys).to match_array(%w[id photo vehicle_id])
    end

    it 'attaches the uploaded photo' do
      gallery = Gallery.last

      expect(gallery.photo_file).to be_attached
      expect(gallery.photo_file.filename.to_s).to eq('car.jpg')
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    it 'invalid with authorization for regular user' do
      file = Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/files/car.jpg'), 'image/jpeg'
      )

      post "/api/v1/vehicles/#{@vehicle.id}/galleries",
           params: { photo_file: file }, headers: { Authorization: @token }
      expect(response.status).to eq(401)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    it 'when photo_file is missing from the request' do
      post "/api/v1/vehicles/#{@vehicle.id}/galleries", params: {}, headers: {
        Authorization: @token_admin
      }
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_content)
      expect(JSON.parse(response.body)['errors']).to include('photo_file is required')
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    it 'when photo_file is blank (explicitly sent empty)' do
      post "/api/v1/vehicles/#{@vehicle.id}/galleries", params: {
        photo_file: ''
      }, headers: { Authorization: @token_admin }
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_content)
      expect(JSON.parse(response.body)['errors']).to include('photo_file is required')
    end
  end

  describe 'POST api/v1/vehicles/:vehicle_id/galleries' do
    it 'invalid without photo parameter for admin users' do
      post "/api/v1/vehicles/#{@vehicle.id}/galleries", params: { vehicle_id: @vehicle.id }, headers: {
        Authorization: @token_admin
      }
      expect(response.status).to eq(422)
      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
