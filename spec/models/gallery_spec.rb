require 'rails_helper'

RSpec.describe Gallery, type: :model do
  before do
    @vehicle = Vehicle.create(model: 'Impreza', description: 'Good vehicle', year: '1996', brand: 'Subaru', color: 'Red',
                              country: 'Japan', power: '310 HP', max_speed: '180 mph', acceleration: '0-100/5.6s',
                              price: 100)
    @gallery = @vehicle.galleries.build
    @gallery.photo_file.attach(
      io: File.open(Rails.root.join('spec/fixtures/files/car.jpg')),
      filename: 'car.jpg',
      content_type: 'image/jpeg'
    )
    @gallery.save!
  end

  context 'When testing Gallery Classs' do
    it 'Should have a vehicle id related' do
      expect(@gallery.vehicle_id).to be(@vehicle.id)
    end

    it 'Should have a photo url' do
      expect(@gallery.photo_file).to be_attached
    end

    it 'Should be valid' do
      expect(@gallery).to be_valid
    end
  end
end
