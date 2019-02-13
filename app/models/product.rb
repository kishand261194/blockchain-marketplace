class Product < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, ImageUploader
  validates_presence_of :name, :price, :quantity, :status
  validates_presence_of :name, :price, :quantity, :status
  validates_numericality_of :price, :quantity, greater_than: 0
  skip_callback :commit, :after, :remove_previously_stored_images
  enum status: [ :avail, :pending, :sold ]
  scope :status, -> (status) { where status: status }
end
