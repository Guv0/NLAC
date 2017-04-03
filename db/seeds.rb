# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
BusinessCard.destroy_all
Tag.destroy_all
TagRelation.destroy_all

User.create(email: 'barack.obama@gmail.com', password: '123456')
BusinessCard.create(user_id: 1, first_name: 'Barack', last_name: 'Obama', email: 'barack.obama@gmail.com', location:'Washington, DC, US', phone: '+1 202 555 0147', industry: 'Politics', company_name: 'USA', description: 'I was better than Trump...', linkedin_picture_url: 'https://consequenceofsound.files.wordpress.com/2016/11/barack.png?w=1614')

User.create(email: 'roger.federer@gmail.com', password: '123456')
BusinessCard.create(user_id: 2, first_name: 'Roger', last_name: 'Federer', email: 'roger.federer@gmail.com', location:'Basel, CH', phone: '+41 977225489', industry: 'Sport', company_name: 'Nike', description: 'Nadal is on steroids...', linkedin_picture_url: '')

User.create(email: 'bob.marley@gmail.com', password: '123456')
BusinessCard.create(user_id: 3, first_name: 'Bob', last_name: 'Marley', email: 'bob.marley@gmail.com', location: 'Heaven', phone: '', industry: 'Music', company_name: 'Rizla', description: 'Smoke a joint and try to fly!', linkedin_picture_url: '')

User.create(email: 'queen.elizabeth@gmail.com', password: '123456')
BusinessCard.create(user_id: 4, first_name: 'Queen', last_name: 'Elizabeth', email: 'queen.elizabeth@gmail.com', location: 'London, United Kingdom, GB', phone: '+44 7632 879367', industry: 'Politics', company_name: 'UK', description: 'Sit and do fuck all :p', linkedin_picture_url: '')

User.create(email: 'bill.gates@gmail.com', password: '123456')
BusinessCard.create(user_id: 5, first_name: 'Bill', last_name: 'Gates', email: 'bill.gates@gmail.com', location: 'Medina, WA, US', phone: '+1 202 555 0131', industry: 'Tech', company_name: 'Microsoft', description: 'Apple sucks!', linkedin_picture_url: '')

User.create(email: 'mark.zuckerberg@gmail.com', password: '123456')
BusinessCard.create(user_id: 6, first_name: 'Mark', last_name: 'Zuckerberg', email: 'mark.zuckerberg@gmail.com', location: 'Palo Alto, CA, US', phone: '+1 202 555 0130', industry: 'Tech', company_name: 'Facebook', description: 'Twitter sucks!', linkedin_picture_url: '')

User.create(email: 'elon.musk@gmail.com', password: '123456')
BusinessCard.create(user_id: 7, first_name: 'Elon', last_name: 'Musk', email: 'elon.musk@gmail.com', location: 'Los Angeles, CA, US', phone: '+1 202 555 0115', industry: 'Tech', company_name: 'Tesla', description: 'All things electrics bro!', linkedin_picture_url: '')

User.create(email: 'edward.ward@gmail.com', password: '123456')
BusinessCard.create(user_id: 8, first_name: 'Edward', last_name: 'Ward', email: 'edward.ward@gmail.com', location: 'London, United Kingdom, GB', phone: '+44 3844 890766', industry: 'Tech', company_name: 'Le Wagon', description: 'Rocking babies and parties!', linkedin_picture_url: '')

User.create(email: 'boris.paillard@gmail.com', password: '123456')
BusinessCard.create(user_id: 9, first_name: 'Boris', last_name: 'Paillard', email: 'boris.paillard@gmail.com', location: 'Paris, FR', phone: '+33 6 11 78 76 35', industry: 'Tech', company_name: 'Le Wagon', description: 'Push to Heroku guys!', linkedin_picture_url: '')

User.create(email: 'sandrine.ayral@gmail.com', password: '123456')
BusinessCard.create(user_id: 10, first_name: 'Sandrine', last_name: 'Ayral', email: 'sandrine.ayral@gmail.com', location: 'London, United Kingdom, GB', phone: '+ 44 6576 871424', industry: 'Tech', company_name: 'Le Wagon', description: '(Not so) secretely looking forward to Demo Day', linkedin_picture_url: '')

puts 'fake users created'

Tag.create(label: 'javascript')
Tag.create(label: 'ruby')
Tag.create(label: 'react')
Tag.create(label: 'entrepreneur')
Tag.create(label: 'design')
Tag.create(label: 'freelancer')
Tag.create(label: 'growthhacking')
Tag.create(label: 'charity')
Tag.create(label: 'teaching')
Tag.create(label: 'AI')

(1..10).to_a.each do |x|
  id_array = (1..10).to_a.sample(4)
  id_array.each do |tag_id|
    TagRelation.create(tag_id: tag_id, business_card_id: x, creator_id: x)
  end
end

puts 'own tags seeded'
