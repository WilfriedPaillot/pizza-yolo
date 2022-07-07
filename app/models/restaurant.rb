class Restaurant < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode, :if => :new_record?

  has_many :restaurant_products
  has_many :products, through: :restaurant_products
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_many :clients, class_name: 'User'
  has_many :restaurant_employees, dependent: :destroy
  has_many :employees, through: :restaurant_employees, class_name: 'User'

  validates :name, presence: true, 
    length: { maximum: 50 },
    format: { with: /\A[a-zA-Z\s'-]+\z/ }
  validates :address, presence: true, 
    length: { maximum: 160 }, 
    format: { with: /\A[a-zA-Z0-9\s,'.-éàèêç]+\z/ }
  validates :zipcode, presence: true, 
    length: { is: 5 }, 
    format: { with: /\A(([0-8][1-9])|(9[0-5]))[0-9]{3}|((97[1-8])[0-9]{2})|((98[1-8])[0-9]{2})|99138\z/ }
  validates :city, presence: true, 
    length: { maximum: 25, message: "is too long (maximum is 25 characters)" },
    format: { with: /\A[a-zA-Z\s'-éèêçà]+\z/ , message: "is not a valid format" }
  validates :email, presence: true,
    length: { maximum: 35 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }
  validates :phone, presence: true,
    length: { is: 10 },
    format: { with: /\A[0]{1}[1-7|9]{1}[0-9]{8}\z/ }

  def full_address
    # [address, zipcode, city].compact.join(', ')
    [zipcode, city].compact.join(', ')
  end

end