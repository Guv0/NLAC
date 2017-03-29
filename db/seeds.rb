# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

User.create(email: 'barack.obama@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Barack', last_name: 'Obama', email: 'barack.obama@gmail.com', location:'Washington, DC, US', phone: '+1 202 555 0147', industry: 'Politics', company_name: 'USA', description: 'I was better than Trump...')

User.create(email: 'roger.federer@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Roger', last_name: 'Federer', email: 'roger.federer@gmail.com', location:'Basel, CH', phone: '+41 977225489', industry: 'Sport', company_name: 'Nike', description: 'Nadal is on steroids...')

User.create(email: 'bob.marley@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Bob', last_name: 'Marley', email: 'bob.marley@gmail.com', location: 'Heaven', phone: '', industry: 'Music', company_name: 'Rizla', description: 'Smoke a joint and try to fly!')

User.create(email: 'queen.elizabeth@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Queen', last_name: 'Elizabeth', email: 'queen.elizabeth@gmail.com', location: 'London, United Kingdom, GB', phone: '+44 7632 879367', industry: 'Politics', company_name: 'UK', description: 'Sit and do fuck all :p')

User.create(email: 'bill.gates@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Bill', last_name: 'Gates', email: 'bill.gates@gmail.com', location: 'Medina, WA, US', phone: '+1 202 555 0131', industry: 'Tech', company_name: 'Microsoft', description: 'Apple sucks!')

User.create(email: 'mark.zuckerberg@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Mark', last_name: 'Zuckerberg', email: 'mark.zuckerberg@gmail.com', location: 'Palo Alto, CA, US', phone: '+1 202 555 0130', industry: 'Tech', company_name: 'Facebook', description: 'Twitter sucks!')

User.create(email: 'elon.musk@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Elon', last_name: 'Musk', email: 'elon.musk@gmail.com', location: 'Los Angeles, CA, US', phone: '+1 202 555 0115', industry: 'Tech', company_name: 'Tesla', description: 'All things electrics bro!')

User.create(email: 'edward.ward@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Edward', last_name: 'Ward', email: 'edward.ward@gmail.com', location: 'London, United Kingdom, GB', phone: '+44 3844 890766', industry: 'Tech', company_name: 'Le Wagon', description: 'Rocking babies and parties!')

User.create(email: 'boris.paillard@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Boris', last_name: 'Paillard', email: 'boris.paillard@gmail.com', location: 'Paris, FR', phone: '+33 6 11 78 76 35', industry: 'Tech', company_name: 'Le Wagon', description: 'Push to Heroku guys!')

User.create(email: 'sandrine.ayral@gmail.com', password: '123456')
BusinessCard.create(first_name: 'Sandrine', last_name: 'Ayral', email: 'sandrine.ayral@gmail.com', location: 'London, United Kingdom, GB', phone: '+ 44 6576 871424', industry: 'Tech', company_name: 'Le Wagon', description: '(Not so) secretely looking forward to Demo Day')

puts 'fake users created'
