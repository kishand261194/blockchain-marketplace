class Product < ApplicationRecord
  belongs_to :user
  has_many :lineitems
  mount_uploaders :images, ImageUploader
  validates_presence_of :name, :price, :quantity, :status
  validates_presence_of :name, :price, :quantity, :status
  validates_numericality_of :price, :quantity, greater_than_or_equal_to: 0
  before_validation :update_status, if: :quantity_zero?
  skip_callback :commit, :after, :remove_previously_stored_images
  enum status: { Available: 'A', Pending: 'P', Sold: 'S' }
  scope :status, -> (status) { where status: status }

  def consume qty
    self.decrement!(:quantity, qty)
  end

  def update_status
    self.status = 'Sold'
  end

  private
  def quantity_zero?
    self.quantity == 0
  end
end
