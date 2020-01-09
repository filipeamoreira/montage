class Image < ApplicationRecord
  belongs_to :image_montage

  has_one_attached :file
end
