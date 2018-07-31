class Picture < ApplicationRecord
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments,
                                reject_if: :reject_family_member,
                                allow_destroy: true

  def reject_family_member(attributes)
    exists = attributes[:id].present?
    empty = attributes[:content].blank?
    attributes.merge!(_destroy: 1) if exists && empty
    !exists && empty
  end
end
