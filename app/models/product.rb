class Product < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :price, :quantity, :status
  validates_presence_of :name, :price, :quantity, :status
  validates_numericality_of :price, :quantity, greater_than: 0

  enum status: [ :avail, :pending, :sold ]
  scope :status, -> (status) { where status: status }
end
