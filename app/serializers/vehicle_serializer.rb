class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :model, :description, :year, :brand, :color, :country, :power, :max_speed, :acceleration, :price,
             :created_at, :updated_at
  has_many :galleries
end
