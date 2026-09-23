class RemovePhotoFromGalleries < ActiveRecord::Migration[8.1]
  def change
    remove_column :galleries, :photo, :string
  end
end
