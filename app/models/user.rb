class User < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?
  before_save :set_default_restaurant

  after_initialize :set_default_role, :if => :new_record?
  after_save :set_user_cart
  after_create :send_welcome_email 

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  enum role: [:client, :manager, :admin]

  belongs_to :restaurant, optional: true
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :working_restaurants, foreign_key: 'employee', class_name: 'RestaurantEmployee', dependent: :destroy
  has_many :restaurants, through: :working_restaurants

  validates :firstname, :lastname, :address, :zipcode, :city, :email, :phone, presence: true, 
    allow_blank: true,
  on: :create
  validates :firstname, :lastname, presence: true, 
    length: { minimum: 2, maximum: 20, message: "doit être compris entre 2 et 20 caractères" }, 
    format: { with: /\A[a-zA-Z\-\'\s\é\è\ê\ç]+\z/ , message: "ne doit contenir que des lettres" },
  on: :update
  validates :address, presence: true, 
    length: { minimum: 5, maximum: 100 }, 
  on: :update
  validates :zipcode, presence: true, 
    numericality: { only_integer: true, greater_than: 01000, less_or_equal_to: 99138 }, 
    length: { is: 5 }, 
  on: :update
  validates :city, presence: true, 
    length: { minimum: 2, maximum: 30 }, 
    format: { with: /\A[a-zA-Z\-\'\s\é\è\ê\ç]+\z/ }, 
  on: :update
  validates :phone, presence: true, 
    length: { is: 10, message: "doit être composé de 10 chiffres" }, 
    format: { with: /\A[0]{1}[1-7]{1}[0-9]{8}\z/, 
      message: "doit être composé de 10 chiffres et commencer par 0" }, 
  on: :update

  def status
    if self.orders.any?
      stage = self.orders.pluck(:total).sum
      case stage
        when 0...100
          status = 'Gouteur'
        when 100...250
          status = 'Petit gourmand'
        when 250...500
          status = 'Gourmand'
        else
          status = 'Gourmand d\'élite'
        end
    end
  end

  def fullname
    "#{firstname.capitalize} #{lastname.upcase}"
  end

  def full_address
    # [address, zipcode, city].compact.join(', ')
    [zipcode, city].compact.join(', ')
  end

  def full_address_changed?
    # self.address_changed? || self.zipcode_changed? || self.city_changed?
    self.zipcode_changed? || self.city_changed?
  end

  def profile_complete?
    !(self.firstname && self.lastname && self.address && self.zipcode && self.city && self.phone).blank?
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
  
  private
  def set_default_role
    self.role ||= :client
  end

  def set_user_cart
    self.cart ||= Cart.create(user: self)
  end

  def set_default_restaurant
    # default_restaurant = Restaurant.near(self.to_coordinates).first
    # self.restaurant = default_restaurant
    self.restaurant = Restaurant.near(self.to_coordinates, 15).first
  end

end
