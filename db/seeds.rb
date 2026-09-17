# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if User.count.zero?
  User.create(name: 'Elson', email: 'elson@capstone.com', password: 'exopasswords')
  User.create(name: 'Giuseppe', email: 'giuseppe@capstone.com', password: 'exopasswords', role: 'admin')
  User.create(name: 'Gonzalo', email: 'gonzalo@capstone.com', password: 'exopasswords', role: 'admin')
  User.create(name: 'Antonio', email: 'antonio@capstone.com', password: 'exopasswords', role: 'admin')
  Vehicle.create(model: 'DMC-12', year: '1985', brand: 'DeLorean', color: 'Silver', country: 'USA',
                 power: '130 HP', max_speed: '175 km/h', acceleration: '9.5 s', price: 500,
                 description: "The DMC DeLorean is a rear-engine two-passenger sports car manufactured and marketed by John DeLorean's DeLorean Motor Company (DMC) for the American market from 1981 until 1983")
  Vehicle.create(model: 'F1-75', brand: 'Ferrari', year: '2022', price: 1250,
                 description: 'The Ferrari F1-75 is a Formula One racing car designed and constructed by Scuderia Ferrari and is competing in the 2022 Formula One World Championship.')
  Vehicle.create(model: 'M2', brand: 'BMW', year: '2023', power: '365 HP', acceleration: '4.3 s',
                 max_speed: '270 km/h', price: 750,
                 description: "The BMW M2 is a high-performance version of the BMW 2 Series automobile developed by BMW's motorsport division, BMW M GmbH.")
  Vehicle.create(model: 'XFC Concept', brand: 'Mitsubishi', year: '2023', price: 450,
                 description: 'Mitsubishi says that the XFC Concept aims to be the "best-suited buddy for an exciting life", whatever that means.')
  Vehicle.create(model: 'A110 R', brand: 'Alpine', year: '2023', power: '300 HP', acceleration: '3.9 s',
                 max_speed: '285 km/h', price: 840,
                 description: 'The ultimate expression of lightness and performance, the Alpine A110 R was designed to be sensational on the racetrack yet still certified for the open road.')
  Booking.create(start_date: '2022-10-24', end_date: '2022-10-28', city: 'São Paulo', user_id: 1, vehicle_id: 3)
  Booking.create(start_date: '2022-10-31', end_date: '2022-11-02', city: 'Cancún', user_id: 3, vehicle_id: 2)
  Booking.create(start_date: '2022-10-26', end_date: '2022-10-28', city: 'San Andrés', user_id: 2, vehicle_id: 4)
  Booking.create(start_date: '2022-10-26', end_date: '2022-10-28', city: 'Punta Gallinas', user_id: 4, vehicle_id: 1)
  Gallery.create(photo: '/images/delorean_dmc12_1.jpg', vehicle_id: 1)
 
  Gallery.create(photo: '/images/ferrari_f175_1.jpg', vehicle_id: 2)
  Gallery.create(photo: '/images/ferrari_f175_2.jpg', vehicle_id: 2)
  Gallery.create(photo: '/images/ferrari_f175_3.jpg', vehicle_id: 2)
  Gallery.create(photo: '/images/ferrari_f175_4.jpg', vehicle_id: 2)
 
  Gallery.create(photo: '/images/bmw_m2_1.jpg', vehicle_id: 3)
  Gallery.create(photo: '/images/bmw_m2_2.jpg', vehicle_id: 3)
 
  Gallery.create(photo: '/images/mitsubishi_xfc_1.jpg', vehicle_id: 4)
  Gallery.create(photo: '/images/mitsubishi_xfc_2.jpg', vehicle_id: 4)
 
  Gallery.create(photo: '/images/alpine_a110r_1.jpg', vehicle_id: 5)
  Gallery.create(photo: '/images/alpine_a110r_2.jpg', vehicle_id: 5)
end
