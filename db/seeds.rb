puts 'seeding 🌱'
# Fake sample service providers
service_provider1 = ServiceProvider.create(username:"provider One", summary:"summary one" )
service_provider2 = ServiceProvider.create(username: "Provider Two", summary: "SUmmary two")

# Fake sample services
service1 = Service.create(name: "House cleaning", description: "Cleaning the entire house", price: 200, service_provider: service_provider1)
service2 = Service.create(name: "Car cleaning", description: "Cleaning all types of vehicles", price: 230, service_provider: service_provider2)

# Fake sample for microservices 
Microservice.create(service: service1, name: 'Toilet cleaning', price: 100)
Microservice.create(service: service1, name: 'Bathroom cleaning', price: 150)
Microservice.create(service: service1, name: 'Window cleaning', price: 180)
Microservice.create(service: service1, name: 'Floor cleaning', price: 140)

Microservice.create(service: service2, name: 'Interior Cleaning', price: 160)
Microservice.create(service: service2, name: 'Exterior Cleaning')
puts 'Done seeding 🌱'