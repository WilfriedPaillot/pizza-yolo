class User < ApplicationRecord
  after_initialize :set_default_role, :if => :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  enum role: [:client, :admin]
  
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :restaurants
  has_one :cart

  # validates :first_name, :last_name, :address, :zipcode, :city, :email, :phone, 
  #   allow_blank: true, 
  # on: :create
  validates :firstname, :lastname, presence: true,
    length: { minimum: 2, maximum: 20, message: "doit être compris entre 2 et 20 caractères" }, 
    format: { with: /\A[a-zA-Z\s\-\']+\z/ , message: "ne doit contenir que des lettres" },
  on: :update
  validates :address, presence: true,
    length: { minimum: 5, maximum: 100 },
  on: :update
  validates :zipcode, presence: true,
    numericality: { only_integer: true, greater_than: 01000, less_or_equal_to: 99138 },
    length: { is: 5 },
  on: :update
  validates :city, presence: true,
    length: { minimum: 2, maximum: 20 },
    format: { with: /\A[a-zA-Z\-\'\s]+\z/ },
  on: :update
  validates :phone, presence: true,
    length: { is: 10, message: "doit être composé de 10 chiffres" },
    format: { with: /\A[0]{1}[1-7]{1}[0-9]{8}\z/, message: "doit être composé de 10 chiffres et commencer par 0" },
  on: :update

  private
  def set_default_role
    self.role ||= :client
  end
end
