# Erase the content of all tables, hence reseting the related "id" counters
DatabaseCleaner.clean_with(:truncation)


# Create 10 random zipcodes between 01000 and 99138
@zipcodes = []
10.times do
  if @zipcodes.empty? || @zipcodes.uniq.length != 10
    zipcode = Faker::Number.leading_zero_number(digits: 5)
    if zipcode.to_i > 01000 && zipcode.to_i < 98899 || zipcode.to_i == 99138
      @zipcodes << zipcode
      # puts "zipcodes: #{@zipcodes}"
    end
  end
end

# Create 10 random phone numbers between 0100000000 and 0599999999
@phones = []
10.times do
  if @phones.empty? || @phones.uniq.length != 10
    phone = Faker::Number.number(digits: 9).to_s
      if phone.to_i > 100000000 && phone.to_i < 599999999
        phone = phone.insert(0, '0')
        @phones << phone
        # puts "phones: #{@phones}"
      end
  end
end

User.create!(
  email: 'paillotwilfried@gmail.com',
  password: 'pizzayolo@2022',
  role: :admin
)

p "#{User.last.email} has been created as an #{User.last.role}"

10.times do
  @first_name = Faker::Name.first_name
  @last_name = Faker::Name.last_name

  User.create!(
  email: @first_name.downcase + '.' + @last_name.downcase + '@yopmail.com',
  password: 'pizzayolo@2022',
  )
  p "#{User.last.email} has been created as an #{User.last.role}"
  
  User.last.update!(
    firstname: @first_name,
    lastname: @last_name,
    address: Faker::Address.street_address,
    zipcode: @zipcodes.sample,
    city: Faker::Address.city,
    phone: @phones.sample,
  )
  p "#{User.last.email} has been updated with the following information:"
  p "First name: #{User.last.firstname}"
  p "Last name: #{User.last.lastname}"
  p "Address: #{User.last.address}"
  p "Zip code: #{User.last.zipcode}"
  p "City: #{User.last.city}"
  p "Phone: #{User.last.phone}"
  p "----------------------------------------------------"
end

p "#{User.where(role: 0).count} users have been created"
p "-----------------------------------------------------"
p ""
Restaurant.create!(
  name: 'Pizza Yolo',
  address: Faker::Address.street_address,
  zipcode: @zipcodes.sample,
  city: Faker::Address.city,
  phone: @phones.sample,
  email: 'pizza-yolo@yopmail.com',
  user_id: User.find_by(role: 1).id
)

p "La pizzeria #{Restaurant.last.name} has been created with the following information:"
p "Zip code: #{Restaurant.last.zipcode}"
p "City: #{Restaurant.last.city}"
p "Email: #{Restaurant.last.email}"
p "-----------------------------------------------------"
p ""

Category.create!(name: 'pizza', description: 'La carte des pizzas')
  p "Category #{Category.last.name} has been created"
  p "-----------------------------------------------------"
  Category.create!(name: 'soda', description: 'Large choix de sodas')
  p "Category #{Category.last.name} has been created"
  p "-----------------------------------------------------"
  Category.create!(name: 'vin', description: 'Carte des vins')
  p "Category #{Category.last.name} has been created"
  p "-----------------------------------------------------"
  p ""

Product.create!(
  name: "Pizza Margherita",
  description: "La pizza Margherita est une spécialité culinaire traditionnelle de la ville de Naples, en Italie",
  price: Faker::Number.decimal(l_digits: 2),
  image_url: "https://medias.delarte.fr/media/sys_master/images/h7a/h75/8863144181790.png",
  restaurant_id: Restaurant.last.id,
  category_id: Category.find_by(name: 'pizza').id
)
p "Product #{Product.last.name} has been created"
p "-----------------------------------------------------"

Product.create!(
  name: "Pizza Marinara",
  description: "La pizza marinara est une spécialité italienne, un des deux types traditionnels de pizza napolitaine.",
  price: Faker::Number.decimal(l_digits: 2),
  image_url: "https://speisekarte.menu/storage/media/contributions/2213802/conversions/contribution_gallery.jpg",
  restaurant_id: Restaurant.last.id,
  category_id: Category.find_by(name: 'pizza').id
)
p "Product #{Product.last.name} has been created"
p "-----------------------------------------------------"

Product.create!(
  name: "Pizza Quattro Formaggi",
  description: "La pizza quattro formaggi est une spécialité italienne, un des deux types traditionnels de pizza napolitaine.",
  price: Faker::Number.decimal(l_digits: 2),
  image_url: "https://assets.afcdn.com/recipe/20200506/110673_w96h73c1cx3120cy2080cxb6240cyb4160.jpg",
  restaurant_id: Restaurant.last.id,
  category_id: Category.find_by(name: 'pizza').id
)
p "Product #{Product.last.name} has been created"
p "-----------------------------------------------------"

Product.create!(
  name: "Pizza carbonara",
  description: "La pizza carbonara est une spécialité italienne, un des deux types traditionnels de pizza napolitaine.",
  price: Faker::Number.decimal(l_digits: 2),
  image_url: "https://assets.afcdn.com/recipe/20210930/122322_w96h73c1cx848cy675cxb2074cyb1445.jpg",
  restaurant_id: Restaurant.last.id,
  category_id: Category.find_by(name: 'pizza').id
)
p "Product #{Product.last.name} has been created"
p "-----------------------------------------------------"
p ""

