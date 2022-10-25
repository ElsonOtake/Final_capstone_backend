require 'rails_helper'

RSpec.describe Gallery, type: :model do
  before do
    @car = Vehicle.create(model: 'Impreza', description: 'Good Car', year: '1996', brand: 'Subaru', color: 'Red', country: 'Japan', power: '310 HP', max_speed: '180 mph', acceleration: '0-100/5.6s', price: 100)
    @gallery = Gallery.create(vehicle_id: @car.id, photo: 'Photo of this car')
  end

  context 'When testing Gallery Classs' do
    it 'Should have a vehicle id related' do
      expect(@gallery.vehicle_id).to be(@car.id)
    end

    it 'Should have a photo url' do
      expect(@gallery.photo).to eq('Photo of this car')
    end

    it 'Should be valid' do
      expect(@gallery).to be_valid
    end
  end
end
