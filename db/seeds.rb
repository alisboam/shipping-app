# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
user = User.create!(name: 'Jane', email: 'jane@sistemadefrete.com.br', password: 'password', role: 'user')

Modality.create!(name: 'Moto', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1000)
Modality.create!(name: 'Bike', min_weight: 1, max_weight: 50, min_distance: 1, max_distance:100, tax: 1500)
Modality.create!(name: 'Kombi', min_weight: 51, max_weight: 1000, min_distance: 101, max_distance:1000, tax: 6000)
Modality.create!(name: 'Van', min_weight: 51, max_weight: 1000, min_distance: 101, max_distance:1000, tax: 6500)
Modality.create!(name: 'Caminhão', min_weight: 1001, max_weight: 20000, min_distance: 102, max_distance: 2000, tax: 5000)
Modality.create!(name: 'Caminhonete', min_weight: 1001, max_weight: 20000, min_distance: 102, max_distance: 2000, tax: 8000)

Vehicle.create!(license_plate: 'ABC1234', brand:'Honda', model:'moto', year: 2015, capacity: 40, status:'ativo', modality_id: 1)
Vehicle.create!(license_plate: 'ZZZ1234', brand:'Caloy', model:'bike', year: 2015, capacity: 40, status:'ativo', modality_id: 2)
Vehicle.create!(license_plate: 'BCD2222', brand:'Toyota', model:'KOMBI', year: 2018, capacity: 2000, status:'ativo', modality_id: 3)
Vehicle.create!(license_plate: 'XXX2222', brand:'Ford', model:'Van', year: 2007, capacity: 2000, status:'ativo', modality_id: 4)
Vehicle.create!(license_plate: 'FGH1234', brand:'Mercedes', model:'Caminhão', year: 2020, capacity: 20000, status:'ativo', modality_id: 5)
Vehicle.create!(license_plate: 'YYY1234', brand:'Hynday', model:'Caminhonete', year: 2013, capacity: 20000, status:'ativo', modality_id: 6)



PricesByDistance.create!(min_distance: 0, max_distance:50, price:900, modality_id: 1)
PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 1)

PricesByDistance.create!(min_distance: 0, max_distance:50, price:800, modality_id: 2)
PricesByDistance.create!(min_distance: 51, max_distance:100, price:1200, modality_id: 2)

PricesByDistance.create!(min_distance: 0, max_distance:50, price:500, modality_id: 3)
PricesByDistance.create!(min_distance: 51, max_distance:100, price:600, modality_id: 3)

PricesByDistance.create!(min_distance: 0, max_distance:1000, price:400, modality_id: 4)
PricesByDistance.create!(min_distance: 51, max_distance:1000, price:500, modality_id: 4)

PricesByDistance.create!(min_distance: 101, max_distance:5000, price:400, modality_id: 5)
PricesByDistance.create!(min_distance: 101, max_distance:1000, price:500, modality_id: 5)

PricesByDistance.create!(min_distance: 101, max_distance:1000, price:400, modality_id: 6)
PricesByDistance.create!(min_distance: 101, max_distance:1000, price:500, modality_id: 6)


PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 1)
PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 15, modality_id: 1)

PricesByWeight.create!(min_weight: 0, max_weight: 30, price: 10, modality_id: 2)
PricesByWeight.create!(min_weight: 31, max_weight: 40, price: 20, modality_id: 2)

PricesByWeight.create!(min_weight: 40, max_weight: 800, price: 10, modality_id: 3)
PricesByWeight.create!(min_weight: 801, max_weight: 20000, price: 10, modality_id: 3)

PricesByWeight.create!(min_weight: 41, max_weight: 800, price: 10, modality_id: 4)
PricesByWeight.create!(min_weight: 801, max_weight: 20000, price: 10, modality_id: 4)

PricesByWeight.create!(min_weight: 200, max_weight: 2000, price: 10, modality_id: 5)
PricesByWeight.create!(min_weight: 2001, max_weight: 200000, price: 10, modality_id:5)

PricesByWeight.create!(min_weight: 200, max_weight: 2000, price: 10, modality_id: 6)
PricesByWeight.create!(min_weight: 2001, max_weight: 200000, price: 10, modality_id: 6)

DeliveryTime.create!(distance_between: 100, hours: 24)
DeliveryTime.create!(distance_between: 200, hours: 48)
DeliveryTime.create!(distance_between: 300, hours: 72)

Order.create!(sender_name: 'Magalu', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'Jane Doe', receiver_address: 'Rua Patati, 25, São Paulo', distance_between: 200, 
              product_code: 'X356-8PQ', weight: 8000, width: 70, height: 45)

Order.create!(sender_name: 'Americanas', sender_address: 'Rua Joaquim, 34, São Paulo', receiver_name: 'John Doe', receiver_address: 'Rua Manuel, São Paulo', distance_between: 30, 
              product_code: 'L325-8XX', weight: 10, width: 70, height: 20)




