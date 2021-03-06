require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    orders: Field::HasMany,
    comments: Field::HasMany,
    restaurants: Field::HasMany,
    cart: Field::HasOne,
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    role: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    firstname: Field::String,
    lastname: Field::String,
    address: Field::String,
    zipcode: Field::String,
    city: Field::String,
    phone: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    email
    role
    orders
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.

  # encrypted_password
  # reset_password_token
  # reset_password_sent_at
  # remember_created_at
  SHOW_PAGE_ATTRIBUTES = %i[
    email
    firstname
    lastname
    address
    zipcode
    city
    phone
    orders
    restaurants
    comments
    cart
    id
    role
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  
  # orders
  # encrypted_password
  # reset_password_token
  # reset_password_sent_at
  # remember_created_at
  FORM_ATTRIBUTES = %i[
    cart
    email
    firstname
    lastname
    address
    zipcode
    city
    phone
    restaurants
    comments
    role
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    "#{user.email}"
  end
end
