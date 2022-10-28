class GallerySerializer < ActiveModel::Serializer
  attributes :id, :photo
  belongs_to :vehicle
end
