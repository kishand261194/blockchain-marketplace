class User < ApplicationRecord
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  validates_numericality_of :balance, greater_than_or_equal_to: 0
  devise :timeoutable, :timeout_in => 10.minutes
  has_many :products
  has_many :lineitems

  def set_default_role
    self.role ||= :user
  end

  def credit amount
    self.update_attribute(:balance, self.balance-amount)
  end

  def debit amount
    self.update_attribute(:balance, self.balance+amount)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
