# Erase the content of all tables, hence reseting the related "id" counters
DatabaseCleaner.clean_with(:truncation)

# Create addresses for users
@address = [
  {
    'zipcode' => '45240',
    'city' => "La ferté saint aubin"
  },
  {
    'zipcode' => '41600',
    'city' => 'Lamotte-Beuvron'
  },
  {
    'zipcode' => '45130',
    'city' => 'Saint Ay'
  },
  {
    'zipcode' => '45100',
    'city' => 'Orléans'
  },
  {
    'zipcode' => '45150',
    'city' => 'Jargeau'
  }
]

# Create 10 random phone numbers between 0100000000 and 0599999999
@phones = []
10.times do
  if @phones.empty? || @phones.uniq.length != 10
    phone = Faker::Number.number(digits: 9).to_s
    if phone.to_i > 100000000 && phone.to_i < 599999999
      phone = phone.insert(0, '0')
      @phones << phone
    end
  end
  puts "phones: #{@phones.last}"
end

  @address.each do |address|
    p "Create restaurant w/ address: #{address['city']}"
    Restaurant.create!(
      name: 'Pizza Yolo',
      address: Faker::Address.street_address,
      zipcode: address['zipcode'],
      city: address['city'],
      email: address['city'].parameterize + '@yopmail.com',
      phone: @phones.sample
    )
    p "La pizzeria #{Restaurant.last.name} has been created with the following information:"
    p "Zip code: #{Restaurant.last.zipcode}"
    p "City: #{Restaurant.last.city}"
    p "Email: #{Restaurant.last.email}"
    p "-----------------------------------------------------"
    p ""
  end


#! ADMIN ACCOUNT
User.create!(
  email: 'paillotwilfried@gmail.com',
  password: 'pizzayolo@2022',
  role: :admin
)
p "#{User.last.email} has been created as an #{User.last.role}"

#! USER ACCOUNTS
5.times do
  @first_name = Faker::Name.first_name
  @last_name = Faker::Name.last_name

  User.create!(
  email: @first_name.downcase + '.' + @last_name.downcase + '@yopmail.com',
  password: 'pizzayolo@2022',
  )
  p "#{User.last.email} has been created as an #{User.last.role}"
  
  random = rand(0..@address.length - 1)
    @zipcode = @address[random]['zipcode']
    @city = @address[random]['city']

  p "Address: #{@city}"
  p "Zip code: #{@zipcode}"

  User.last.update!(
    firstname: @first_name,
    lastname: @last_name,
    address: Faker::Address.street_address,
    zipcode: @zipcode,
    city: @city,
    phone: @phones.sample,
  )

  p "User.last.firstname: #{User.last.email} updated with the following information:"
  p "First name: #{User.last.firstname}"
  p "Last name: #{User.last.lastname}"
  p "Address: #{User.last.address}"
  p "Zip code: #{User.last.zipcode}"
  p "City: #{User.last.city}"
end

p "#{User.where(role: 0).count} users have been created"
p "-----------------------------------------------------"
p ""

@pizzas = [
  {	'name' => 'Margarita',
    'description' => 'La pizza Margherita est une spécialité culinaire traditionnelle de la ville de Naples, en Italie',
    'price' => 8.50,
  },
  {	'name' => 'Marinara',
    'description' => 'La pizza marinara est une spécialité italienne, un des deux types traditionnels de pizza napolitaine.',
    'price' => 11.20,
  },
  {	'name' => 'Quattro formaggi',
    'description' => 'La pizza quattro formaggi est une spécialité italienne, un des deux types traditionnels de pizza napolitaine.',
    'price' => 12.50,
  }
]

Category.create!(name: 'pizza', description: 'Nos authentiques pizzas')
  p "Category #{Category.last.name} has been created"
  p "-----------------------------------------------------"

  @pizzas.each do |pizza|
    Product.create!(
      name: pizza['name'],
      description: pizza['description'],
      price: pizza['price'],
      category: Category.last,
      image_url: "https://via.placeholder.com/150"
    )
  end
  

Category.create!(name: 'boisson', description: 'Large choix de sodas')
  p "Category #{Category.last.name} has been created"
  p "-----------------------------------------------------"
  
  @drinks = [
    {	
      'name' => 'Coca-Cola',
      'description' => "Coca-Cola est une boisson non-alcoolisée produite par la société Coca-Cola."
    },
    {
      'name' => 'Sprite',
      'description' => "Sprite est une boisson non-alcoolisée produite par la société Coca-Cola."
    },
    {
      'name' => 'Fanta',
      'description' => "Fanta est une boisson non-alcoolisée produite par la société Coca-Cola."
    },
    {
      'name' => 'Pepsi',
      'description' => "Pepsi est une boisson non-alcoolisée produite par la société PepsiCo. ! Ahhhh sous le soleil de PepsiCo..."
    }
  ]

  @drinks.each do |drink|
    Product.create!(
      name: drink['name'],
      description: drink['description'],
      price: rand(1..3).to_f,
      category: Category.last,
      image_url: "https://via.placeholder.com/150"
    )
  end

  p "Product #{Product.last.name} has been created"
  p "-----------------------------------------------------"
  p ""
  
  
  Category.create!(name: 'dessert', description: 'Spécialités de desserts')
    p "Category #{Category.last.name} has been created"
    p "-----------------------------------------------------"
    p ""

    @desserts = [
      {	
        'name' => 'Tiramisu',
        'description' => "Tiramisu est un dessert au lait qui est préparé à partir de la crème brulée et des fruits frais."
      },
      {
        'name' => 'Tarte aux pommes',
        'description' => "Tarte aux pommes Maison"
      },
      {
        'name' => 'Tarte Tatin',
        'description' => "Tarte Tatin, spécialité de la ville de Lamotte-Beuvron dans le Loir-et-Cher."
      }
    ]

    @desserts.each do |dessert|
      Product.create!(
        name: dessert['name'],
        description: dessert['description'],
        price: rand(3..6).to_f,
        category: Category.last,
        image_url: "https://via.placeholder.com/150"
      )
    end
      
      p "Product #{Product.last.name} has been created"
      p "-----------------------------------------------------"
      p ""

p "-----------------------------------------------------"
p "And voila!"
p "-----------------------------------------------------"

Order.create!(reference: "test1", total: 99.98, user_id: User.last.id, restaurant_id: 1, scheduled_time: Time.now)
  # p "Order #{Order.last.reference} has been created"
  OrderProduct.create!(order_id: Order.last.id, product_id: 1, quantity: 2)
  OrderProduct.create!(order_id: Order.last.id, product_id: 3)
  
Order.create!(reference: "test2", total: 59.95, user_id: User.last.id, restaurant_id: 1, scheduled_time: Time.now)
  # p "Order #{Order.last.reference} has been created"
  OrderProduct.create!(order_id: Order.last.id, product_id: 2, quantity: 3)
  OrderProduct.create!(order_id: Order.last.id, product_id: 3, quantity: 2)