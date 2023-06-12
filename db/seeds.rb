puts 'seeding 🌱'
# Fake sample service providers
# service_provider1 = ServiceProvider.create(username:"provider One", summary:"summary one" )
# service_provider2 = ServiceProvider.create(username: "Provider Two", summary: "SUmmary two")

# # Fake Sample Customers
# customer1 = Customer.create(username: 'Scientist')
# customer2 = Customer.create(username: 'Rose')

# # Fake sample services
# service1 = Service.create(name: "House cleaning", description: "Cleaning the entire house", price: 200, service_provider: service_provider1)
# service2 = Service.create(name: "Car cleaning", description: "Cleaning all types of vehicles", price: 230, service_provider: service_provider2)

# Fake sample for bookings
Booking.create(
    customer_id: 1,
    service_provider_id: 1,
    service_date: '2023-03-14',
    service_time: '12:00',
    payment_method: 'Mpesa'
)
Booking.create(
    customer_id: 2,
    service_provider_id: 2,
    service_date: '2023-05-14',
    service_time: '10:00',
    payment_method: 'Mpesa'
)

# Fake sample for microservices 
Microservice.create(service: service1, name: 'Toilet cleaning', price: 100)
Microservice.create(service: service1, name: 'Bathroom cleaning', price: 150)
Microservice.create(service: service1, name: 'Window cleaning', price: 180)
Microservice.create(service: service1, name: 'Floor cleaning', price: 140)

Microservice.create(service: service2, name: 'Interior Cleaning', price: 160)
Microservice.create(service: service2, name: 'Exterior Cleaning')


10.times do
    Review.create(
        customer_id: rand(1..2), 
        service_provider_id: rand(1..2),
        rating: rand(1..5),
        comment: Faker::Lorem.sentence
      )
  end

puts 'Done seeding 🌱'