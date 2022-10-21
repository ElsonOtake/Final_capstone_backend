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
Vehicle.create(model: 'Testarossa', year: '1996', brand: 'Ferrari', color: 'Red', country: 'Italy',
               power: '385 HP', max_speed: '290 km/h', acceleration: '5.8 s', price: 1000)
Vehicle.create(model: 'Isetta', max_speed: '85 km/h', brand: 'Iso Automotoveicoli', year: '1956', power: '13 HP',
               price: 12,
               description: 'The Isetta is an Italian-designed microcar built under license in a number of different countries.')
Vehicle.create(model: 'Ghost', brand: 'Rolls Royce', year: '2022', power: '603 HP', acceleration: '4.8 s',
               max_speed: '250 km/h', price: 999)
Vehicle.create(model: 'Model 3', brand: 'Tesla', year: '2021', power: '283 HP', acceleration: '3.3 s',
               max_speed: '261 km/h', price: 240)
Vehicle.create(model: 'A110 R', brand: 'Alpine', year: '2023', power: '300 HP', acceleration: '3.9 s',
               max_speed: '285 km/h', price: 840)
Booking.create(start_date: '2022-10-24', end_date: '2022-10-28', city: 'São Paulo', user_id: 1, vehicle_id: 2)
Booking.create(start_date: '2022-10-31', end_date: '2022-11-02', city: 'Cancún', user_id: 3, vehicle_id: 2)
Booking.create(start_date: '2022-10-26', end_date: '2022-10-28', city: 'San Andrés', user_id: 2, vehicle_id: 4)
Booking.create(start_date: '2022-10-26', end_date: '2022-10-28', city: 'Punta Gallinas', user_id: 4, vehicle_id: 1)
Galery.create(photo: 'https://www.wsupercars.com/wallpapers-regular/Alpine/2023-Alpine-A110-R-001-1080.jpg',
              vehicle_id: 5)
Galery.create(photo: 'https://www.wsupercars.com/wallpapers-regular/Alpine/2023-Alpine-A110-R-002-1080.jpg',
              vehicle_id: 5)
