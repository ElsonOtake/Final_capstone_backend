class GalerySerializer < ActiveModel::Serializer
  attributes :id, :photo
  belongs_to :vehicle
end
