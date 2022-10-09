# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
user = User.create!(name: 'Jane', email: 'jane@sistemadefrete.com.br', password: 'password', role: 'user')

modality = Modality.create!(name: 'Caminhão', min_weight: 0, max_weight: 1000, min_distance: 51, max_distance:150, tax: 5, status: 'ativo')

Vehicle.create!(license_plate: 'ABC1234', brand:'Ford', model:'Ka', year: 2015, capacity:10000, status:'ativo', modality: modality)
Vehicle.create!(license_plate: 'BCD2222', brand:'Toyota', model:'Caminhão', year: 2018, capacity:2000000, status:'ativo', modality: modality)


PricesByDistance.create!(min_distance: 0, max_distance:50, price:9000)
PricesByDistance.create!(min_distance: 51, max_distance:150, price:12000)
PricesByDistance.create!(min_distance: 151, max_distance:800, price:200000)

PricesByWeight.create!(min_weight: 0, max_weight:1000, price:50)
PricesByWeight.create!(min_weight: 11000, max_weight:30000, price:80)
PricesByWeight.create!(min_weight: 101, max_weight:100000, price:100)

