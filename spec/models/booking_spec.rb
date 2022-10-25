require 'rails_helper'

RSpec.describe Booking, type: :model do
  before do
    @user = User.create(name: 'Antonio', role: 'admin', email: 'antonio@mail.com', password: 'password')
    @car = Vehicle.create(model: 'Impreza', description: 'Good Car', year: '1996', brand: 'Subaru', color: 'Red', country: 'Japan', power: '310 HP', max_speed: '180 mph', acceleration: '0-100/5.6s', price: 100)
    @booking = Booking.create(user_id: @user.id, vehicle_id: @car.id, start_date: '22/10/2022', end_date: '25/11/2022', city: 'Manizales')
  end

  context 'When testing Booking Class' do
    it 'Should be valid' do
      expect(@booking).to be_valid
    end

    it 'Start date should exist' do
      @booking.start_date = nil
      expect(@booking).to_not be_valid
    end

    it 'End date should exist' do
      @booking.end_date = nil
      expect(@booking).to_not be_valid
    end

    it 'City should exist' do
      @booking.city = nil
      expect(@booking).to_not be_valid
    end

    it 'Should have a vehicle id related' do
      @booking.vehicle_id = nil
      expect(@booking).to_not be_valid
    end

    it 'Should have a user id related' do
      @booking.user_id = nil
      expect(@booking).to_not be_valid
    end
  end
end
