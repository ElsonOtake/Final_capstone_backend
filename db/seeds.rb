# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(name: 'Elson', email: 'elson@capstone.com', password: 'password')
User.create(name: 'Giuseppe', email: 'giuseppe@capstone.com', password: 'password', role: 'admin')
User.create(name: 'Gonzalo', email: 'gonzalo@capstone.com', password: 'password', role: 'admin')
User.create(name: 'Antonio', email: 'antonio@capstone.com', password: 'password', role: 'admin')
Vehicle.create(model: 'Testarossa', year: 1996, brand: 'Ferrari', color: 'Red', country: 'Italy',
               power: '385hp', max_speed: '290km/h', acceleration: 5.8, price: 1000)
Vehicle.create(model: 'Isetta', max_speed: '85km/h', brand: 'Iso Automotoveicoli', year: 1956, power: '13hp',
                        price: 12)
Vehicle.create(model: 'Ghost', brand: 'Rolls Royce', year: 2022, power: '603hp', acceleration: 4.8,
               max_speed: '250km/h', price: 999)
Vehicle.create(model: 'Model 3', brand: 'Tesla', year: 2021, power: '283hp', acceleration: 3.3,
                        max_speed: '261km/h', price: 240)
Booking.create(duration: Date.new(2022, 10, 24)..Date.new(2022, 10, 28), city: 'São Paulo', user_id: 1,
               vehicle_id: 2)
Booking.create(duration: Date.new(2022, 10, 31)..Date.new(2022, 11, 2), city: 'Cancún', user_id: 3,
               vehicle_id: 2)
Booking.create(duration: Date.new(2022, 10, 26)..Date.new(2022, 10, 28), city: 'San Andrés', user_id: 2,
               vehicle_id: 4)
Booking.create(duration: Date.new(2022, 10, 26)..Date.new(2022, 10, 28), city: 'Punta Gallinas', user_id: 4,
               vehicle_id: 1)
