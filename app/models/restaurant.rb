class Restaurant < ApplicationRecord
  has_many :products
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, 
    length: { maximum: 50 },
    format: { with: /\A[a-zA-Z\s'-]+\z/ }
  validates :address, presence: true, 
    length: { maximum: 160 }, 
    format: { with: /\A[a-zA-Z0-9\s,'.-]+\z/ }
  validates :zipcode, presence: true, 
    length: { is: 5 }, 
    format: { with: /\A(([0-8][1-9])|(9[0-5]))[0-9]{3}|((97[1-8])[0-9]{2})|((98[1-8])[0-9]{2})|99138\z/ }
  validates :city, presence: true, 
    length: { maximum: 25 }, 
    format: { with: /\A[a-zA-Z\s,'.-]+\z/ }
  validates :email, presence: true,
    length: { maximum: 35 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }
  validates :phone, presence: true,
    length: { is: 10 },
    format: { with: /\A[0]{1}[1-7]{1}[0-9]{8}\z/ }
end
