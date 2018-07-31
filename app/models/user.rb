class User < ApplicationRecord
  has_secure_password

  validates :name,
    presence: true,
    length: { maximum: 30 },
    uniqueness: true,
    if: :icon_not_presence?
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: true,
    if: :icon_not_presence?
  before_save { email.downcase! }
  validates :password,
    presence: true,
    length: { minimum:6 },
    if: :icon_not_presence?

  def icon_not_presence?
    icon.blank?
  end

  has_many :pictures, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture
  has_many :comments, dependent: :destroy
  mount_uploader :icon, ImageUploader

end
