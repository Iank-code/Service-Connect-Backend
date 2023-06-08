puts "📃 Seeding data..."

10.times do
  Review.create(
      customer_id: rand(1..10), 
      service_provider_id: rand(1..10),
      rating: rand(1..5),
      comment: Faker::Lorem.sentence
    )
end

puts "✅ Done seeding"


