require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  before do
    @car = Vehicle.create(model: 'Impreza', description: 'Good Car', year: '1996', brand: 'Subaru', color: 'Red',
                          country: 'Japan', power: '310 HP', max_speed: '180 mph', acceleration: '5.6s', price: 100)
  end

  context 'When testing Vehicle Class' do
    it 'Should have model' do
      expect(@car.model).to eq('Impreza')
    end

    it 'Model should exist' do
      @car.model = nil
      expect(@car).to_not be_valid
    end

    it 'Should have brand' do
      expect(@car.brand).to eq('Subaru')
    end

    it 'Should have price' do
      expect(@car.price).to eq(100)
    end

    it 'Price should exist' do
      @car.price = nil
      expect(@car).to_not be_valid
    end

    it 'Price should be greater or equal to 0' do
      @car.price = -1
      expect(@car).to_not be_valid
    end

    it 'Price should be greater or equal to 0' do
      expect(@car.price).to be >= 0
    end

    it 'Price should be numeric' do
      expect(@car.price).to be_an(Numeric)
    end
  end
end
