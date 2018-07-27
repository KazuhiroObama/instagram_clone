class Icon < ApplicationRecord
  belongs_to :user
  mount_uploader :thumbnail, ImageUploader
  validates :thumbnail, presence: true
end
