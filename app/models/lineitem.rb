class Lineitem < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates_numericality_of :total, :quantity, greater_than: 0
  before_validation :check_quantity_balance_and_credit_seller

  def seller
    product.user
  end

  private
  def check_quantity_balance_and_credit_seller
    if self.quantity <= product.quantity
      if self.total <= self.user.balance
        ActiveRecord::Base.transaction do
          self.product.consume(self.quantity)
          self.user.debit(self.total)
          self.seller.credit(self.total)
        end
        true
      else
        errors.add(:base, "Insufficient funds! Please visit you profile to add funs.")
        false
      end
    else
      errors.add(:base, "Seller does not have the requested quantity")
      false
    end
  end
end
