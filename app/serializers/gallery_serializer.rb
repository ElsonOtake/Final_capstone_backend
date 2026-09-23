class GallerySerializer < ActiveModel::Serializer
  attributes :id, :vehicle_id, :photo

  def photo
    return unless object.photo_file.attached?

    Rails.application.routes.url_helpers.rails_blob_url(object.photo_file)
  end
end
