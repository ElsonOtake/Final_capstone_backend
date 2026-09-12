require 'rails_helper'

RSpec.describe Booking, type: :model do
  before do
    @user = User.create(name: 'Antonio', role: 'admin', email: 'antonio@mail.com', password: 'password')
    @car = Vehicle.create(model: 'Impreza', description: 'Good Car', year: '1996', brand: 'Subaru', color: 'Red',
                          country: 'Japan', power: '310 HP', max_speed: '180 mph', acceleration: '0-100/5.6s',
                          price: 100)
    @booking = Booking.create(user_id: @user.id, vehicle_id: @car.id, start_date: '2022-10-22', end_date: '2022-11-25',
                              city: 'Manizales')
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

    it 'End date should be after the start date' do
      @booking.start_date = '2022-11-20'
      @booking.end_date = '2022-11-10'
      expect(@booking).to_not be_valid
    end

    it 'Should have a specific error message when end date is not after start date' do
      @booking.start_date = '2022-11-20'
      @booking.end_date = '2022-11-10'
      @booking.valid?
      expect(@booking.errors[:end_date]).to include('must be after the start date')
    end

    it 'Should have a specific error message when end date equals start date' do
      @booking.start_date = '2022-11-20'
      @booking.end_date = '2022-11-20'
      expect(@booking).to_not be_valid
      expect(@booking.errors[:end_date]).to include('must be after the start date')
    end

    it 'Should not allow a booking that overlaps an existing booking for the same vehicle' do
      overlapping_booking = Booking.new(user_id: @user.id, vehicle_id: @car.id, start_date: '2022-11-01',
                                        end_date: '2022-11-10', city: 'Manizales')
      expect(overlapping_booking).to_not be_valid
    end

        it 'Should have a specific error message when a booking overlaps an existing one' do
      overlapping_booking = Booking.new(user_id: @user.id, vehicle_id: @car.id, start_date: '2022-11-01',
                                        end_date: '2022-11-10', city: 'Manizales')
      overlapping_booking.valid?
      expect(overlapping_booking.errors[:base]).to include('Vehicle is already booked for the selected dates')
    end

    it 'Should not flag an overlap for a different vehicle with the same dates' do
      other_car = Vehicle.create(model: 'Civic', price: 80)
      same_dates_other_vehicle = Booking.new(user_id: @user.id, vehicle_id: other_car.id, start_date: '2022-11-01',
                                             end_date: '2022-11-10', city: 'Manizales')
      expect(same_dates_other_vehicle).to be_valid
    end

    it 'Should flag an overlap when a new booking starts on an existing booking\'s end date (inclusive boundary)' do
      adjacent_booking = Booking.new(user_id: @user.id, vehicle_id: @car.id, start_date: '2022-11-25',
                                     end_date: '2022-12-01', city: 'Manizales')
      expect(adjacent_booking).to_not be_valid
      expect(adjacent_booking.errors[:base]).to include('Vehicle is already booked for the selected dates')
    end

    it 'Should allow a non-overlapping booking for the same vehicle' do
      non_overlapping_booking = Booking.new(user_id: @user.id, vehicle_id: @car.id, start_date: '2022-12-01',
                                            end_date: '2022-12-10', city: 'Manizales')
      expect(non_overlapping_booking).to be_valid
    end

    it 'Should allow updating an existing booking without conflicting with itself' do
      @booking.city = 'Cali'
      expect(@booking).to be_valid
    end
  end
end
