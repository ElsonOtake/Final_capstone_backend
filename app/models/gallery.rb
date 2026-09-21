class Gallery < ApplicationRecord
  belongs_to :vehicle

  has_one_attached :photo_file

  validates :photo_file, presence: true, on: :create
end
