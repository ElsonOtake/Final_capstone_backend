class User < ApplicationRecord
  self.table_name = 'exo_cars_users'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings, dependent: :destroy
  before_validation :normalize_email
  validates :name, presence: true

  def is?(requested_role)
    role == requested_role.to_s
  end

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
