# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user_admin = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', role: 'admin')
user = User.create!(name: 'Jane', email: 'jane@sistemadefrete.com.br', password: 'password', role: 'user')

Vehicle.create!(license_plate: 'ABC1234', brand:'Ford', model:'Ka', year: 2015, capacity:10000, status:'inativo')

Vehicle.create!(license_plate: 'BCD2222', brand:'Toyota', model:'Caminhão', year: 2018, capacity:2000000, status:'ativo')