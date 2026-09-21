# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
# NOTE: Gallery photo URLs below point to /images/... which are served from
# your Rails app's public/ folder (e.g. public/images/delorean_dmc12_1.jpg).
# Download each vehicle's images and place them there using these exact
# filenames, or update the paths to match whatever filenames you use.
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

  cars = [['1981-DeLorean-DMC-12-001-1080', 1], ['2022-Formula1-Ferrari-F1-75-005-1080', 2],
          ['2022-Formula1-Ferrari-F1-75-006-1080', 2], ['2022-Formula1-Ferrari-F1-75-007-1080', 2],
          ['2022-Formula1-Ferrari-F1-75-008-1080', 2], ['2023-BMW-M2-004-1080', 3],
          ['2023-BMW-M2-005-1080', 3], ['2022-Mitsubishi-XFC-Concept-001-1080', 4],
          ['2022-Mitsubishi-XFC-Concept-002-1080', 4], ['2023-Alpine-A110-R-001-1080', 5],
          ['2023-Alpine-A110-R-002-1080', 5]]

  cars.each do |car, vehicle_id|
    vehicle = Vehicle.find(vehicle_id)
    gallery = vehicle.galleries.build
    gallery.photo_file.attach(
      io: File.open(Rails.root.join("public/images/#{car}.jpg")),
      filename: "#{car}.jpg",
      content_type: 'image/jpeg'
    )
    gallery.save!
  end
end
