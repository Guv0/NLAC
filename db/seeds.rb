User.destroy_all
BusinessCard.destroy_all
Tag.destroy_all
TagRelation.destroy_all
Connection.destroy_all
Community.destroy_all
CommunityMembership.destroy_all
Conversation.destroy_all
Message.destroy_all

User.create(email: 'barack.obama@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 1, first_name: 'Barack', last_name: 'Obama', email: 'barack.obama@gmail.com', location:'Washington, DC, US', phone: '+1 202 555 0147', industry: 'Politics', company_name: 'USA', description: 'I was better than Trump...', linkedin_picture_url: 'https://consequenceofsound.files.wordpress.com/2016/11/barack.png?w=1614', updates: [])

User.create(email: 'roger.federer@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 2, first_name: 'Roger', last_name: 'Federer', email: 'roger.federer@gmail.com', location:'Basel, CH', phone: '+41 977225489', industry: 'Sport', company_name: 'Nike', description: 'Nadal is on steroids...', linkedin_picture_url: 'http://1v1d1e1lmiki1lgcvx32p49h8fe.wpengine.netdna-cdn.com/wp-content/uploads/2017/01/Roger-Federer-2017-960x540.jpg', updates: [])

User.create(email: 'bob.marley@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 3, first_name: 'Bob', last_name: 'Marley', email: 'bob.marley@gmail.com', location: 'Heaven', phone: '', industry: 'Music', company_name: 'Rizla', description: 'Smoke a joint and try to fly!', linkedin_picture_url: '', updates: [])

User.create(email: 'queen.elizabeth@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 4, first_name: 'Queen', last_name: 'Elizabeth', email: 'queen.elizabeth@gmail.com', location: 'London, United Kingdom, GB', phone: '+44 7632 879367', industry: 'Politics', company_name: 'UK', description: 'Sit and do fuck all :p', linkedin_picture_url: '', updates: [])

User.create(email: 'bill.gates@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 5, first_name: 'Bill', last_name: 'Gates', email: 'bill.gates@gmail.com', location: 'Medina, WA, US', phone: '+1 202 555 0131', industry: 'Tech', company_name: 'Microsoft', description: 'Apple sucks!', linkedin_picture_url: '', updates: [])

User.create(email: 'mark.zuckerberg@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 6, first_name: 'Mark', last_name: 'Zuckerberg', email: 'mark.zuckerberg@gmail.com', location: 'Palo Alto, CA, US', phone: '+1 202 555 0130', industry: 'Tech', company_name: 'Facebook', description: 'Twitter sucks!', linkedin_picture_url: '', updates: [])

User.create(email: 'elon.musk@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 7, first_name: 'Elon', last_name: 'Musk', email: 'elon.musk@gmail.com', location: 'Los Angeles, CA, US', phone: '+1 202 555 0115', industry: 'Tech', company_name: 'Tesla', description: 'All things electrics bro!', linkedin_picture_url: '', updates: [])

User.create(email: 'edward.ward@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 8, first_name: 'Edward', last_name: 'Ward', email: 'edward.ward@gmail.com', location: 'London, United Kingdom, GB', phone: '+44 3844 890766', industry: 'Tech', company_name: 'Le Wagon', description: 'Rocking babies and parties!', linkedin_picture_url: '', updates: [])

User.create(email: 'boris.paillard@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 9, first_name: 'Boris', last_name: 'Paillard', email: 'boris.paillard@gmail.com', location: 'Paris, FR', phone: '+33 6 11 78 76 35', industry: 'Tech', company_name: 'Le Wagon', description: 'Push to Heroku guys!', linkedin_picture_url: '', updates: [])

User.create(email: 'sandrine.ayral@gmail.com', password: '123456', provider: 'linkedin')
BusinessCard.create(user_id: 10, first_name: 'Sandrine', last_name: 'Ayral', email: 'sandrine.ayral@gmail.com', location: 'London, United Kingdom, GB', phone: '+ 44 6576 871424', industry: 'Tech', company_name: 'Le Wagon', description: '(Not so) secretely looking forward to Demo Day', linkedin_picture_url: '', updates: [])

puts 'fake users created'

Tag.create!(label: 'javascript')
Tag.create!(label: 'ruby')
Tag.create!(label: 'react')
Tag.create!(label: 'entrepreneur')
Tag.create!(label: 'design')
Tag.create!(label: 'freelancer')
Tag.create!(label: 'growthhacking')
Tag.create!(label: 'charity')
Tag.create!(label: 'teaching')
Tag.create!(label: 'AI')
Tag.create!(label: 'personal')

(1..10).to_a.each do |x|
  id_array = (1..10).to_a.sample(4)
  id_array.each do |tag_id|
    TagRelation.create!(tag_id: tag_id, business_card_id: x, creator_id: x)
  end
end

puts 'own tags seeded'

(1..10).to_a.each do |x|
  contact_array = (1..10).to_a.sample(5)
  contact_array.each do |y|
    if x != y
    Connection.create!(user_id: x, contact_id: y)
    TagRelation.create!(tag_id: 11, business_card_id: y, creator_id: x)
    end
  end
end

puts 'connections with personal tag seeded'

Community.create!(name:'Illuminati', description: 'Blah blah blah blah blah blah', photo:'')

CommunityMembership.create!(member_id: 1, community_id: 1, manager: true)
(2..6).to_a.each do |x|
  CommunityMembership.create!(member_id: x, community_id: 1)
end

puts 'community seeded with barack as manager and users 2-6 as members'

Conversation.create!(sender_id: 1, recipient_id: 2, subject: "Whagwan Bruv!")
Conversation.create!(sender_id: 1, recipient_id: 3, subject: "Whagwan Bruv!")
Conversation.create!(sender_id: 1, recipient_id: 4, subject: "Whagwan Bruv!")
Conversation.create!(sender_id: 1, recipient_id: 5, subject: "Whagwan Bruv!")
Conversation.create!(sender_id: 1, recipient_id: 6, subject: "Whagwan Bruv!")
Conversation.create!(sender_id: 2,recipient_id: 4)
Conversation.create!(sender_id: 2,recipient_id: 5)

Conversation.all.each do |conversation|
  conversation.update(started_on: conversation.started_on)
  conversation.save
end

5.times do
  message = Message.create!(conversation_id: 1, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 1)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(1)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 1, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 2)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(1)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 2, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 1)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(2)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 2, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 3)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(2)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 3, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 1)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(3)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 3, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 4)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(3)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 4, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 1)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(4)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 4, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 5)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(4)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 5, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 1)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(5)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 5, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 6)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(5)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 6, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 2)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(6)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 6, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 4)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(6)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 7, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 2)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(7)
  conversation.last_message = DateTime.now
  conversation.save
  message = Message.create!(conversation_id: 7, body: "Please be my friend! I'm so lonely and really want someone to talk to and share my feelings. Please accept my request, if you don't, I don't know how I am going to go on. Safe Blood. Peace.", user_id: 5)
  message.sent_at = message.message_time
  message.sender = message.sender_name
  message.save
  conversation = Conversation.find(7)
  conversation.last_message = DateTime.now
  conversation.save
end

# require 'faker'

# # cleaning database
# puts 'Destroying all models...'
# CommunityMembership.destroy_all
# CommunityRequest.destroy_all
# Community.destroy_all
# ConnectionRequest.destroy_all
# Connection.destroy_all
# Message.destroy_all
# Conversation.destroy_all
# TagRelation.destroy_all
# Tag.destroy_all
# BusinessCard.destroy_all
# User.destroy_all
# puts 'Models are destroyed, database is clean.'

# creating users
puts 'Creating 100 fake users and their fake business card...'
90.times do
  user =  User.create!(
            email: Faker::Internet.free_email,
            password: '123456'
          )
  user.business_card.update(
    user_id: user.id,
    first_name: user.email.match(/.+?(?=[@, _, -, .])/)[0].capitalize,
    last_name: Faker::Name.last_name,
    email: user.email,
    location: Faker::Address.city,
    phone: Faker::PhoneNumber.cell_phone,
    industry: Faker::Job.field,
    company_name: Faker::Company.name,
    position: Faker::Job.title,
    description: Faker::Lorem.sentence(20, false, 0),
    updates: [],
    # need to add a photo
  )
end
puts 'Fake users and business cards created.'

# creating tags
puts 'Creating 12 fake tags...'
10.times do
  Tag.create!(label: Faker::Job.unique.key_skill)
end
puts 'Fake tags created.'

# assigning own tags
puts 'Assigning 8 own tags to 100 business card...'
(11..100).to_a.each do |tagger_id|
  tag_ids = (1..21).to_a.sample(8)
  tag_ids.each do |tag_id|
    TagRelation.create!(tag_id: tag_id, business_card_id: tagger_id, creator_id: tagger_id)
  end
end
puts 'Own tags assigned.'

# creating connections with 1 'personal' tag
puts 'Creating 50 connections for each user with 1 "personal" tag...'
(11..100).to_a.each do |first_id|
  second_id_array = (1..100).to_a.sample(50)
  second_id_array.each do |second_id|
    if first_id != second_id
      Connection.create!(user_id: first_id, contact_id: second_id)
      TagRelation.create!(tag_id: 13, business_card_id: second_id, creator_id: first_id)
    end
  end
end
puts 'Connections with "personal" tag created.'

# creating communities
puts 'Creating 10 fake communities with 20 members each...'
10.times do
  community =  Community.create!(
                name: Faker::RockBand.name,
                description: Faker::Lorem.sentences(1)
                # need to add a photo
              )
  manager_id = (1..100).to_a.sample(1)
  CommunityMembership.create!(member_id: manager_id[0], community_id: community.id, manager: true)
  member_ids = (1..100).to_a.shuffle.take(20)
  member_ids.each do |member_id|
    CommunityMembership.create!(member_id: member_id, community_id: community.id) if member_id != manager_id
  end
end
puts 'Fake communities created.'

# # creating conversations with messages
# puts 'Creating 10 conversation for each user with 10 messages in each of them...'
# (1..100).to_a.each do |sender_id|
#   (1..100).to_a.shuffle.take(10).each do |recipient_id|
#     if sender_id != recipient_id
#       conversation =  Conversation.create!(
#                         sender_id: sender_id,
#                         recipient_id: recipient_id
#                       )
#       conversation.update(started_on: conversation.started_on)
#       conversation.save
#       10.times do
#         message_a =   Message.create!(
#                         conversation_id: conversation.id,
#                         body: Faker::Lorem.paragraph(2, false, 4),
#                         user_id: sender_id
#                       )
#         message_a.sent_at = message_a.message_time
#         message_a.sender = message_a.sender_name
#         message_a.save
#         message_b =   Message.create!(
#                         conversation_id: conversation.id,
#                         body: Faker::Lorem.paragraph(2, false, 4),
#                         user_id: recipient_id
#                       )
#         message_b.sent_at = message_b.message_time
#         message_b.sender = message_b.sender_name
#         message_b.save
#       end
#     end
#   end
# end
# puts 'Fake conversations created.'

# # creating connection requests
# puts 'Creating 3 connection requests received and 1 sent for each user...'
# (1..100).to_a.each do |user_id|
#   (1..100).to_a.shuffle.take(3).each do |contact_id|
#     ConnectionRequest.create!(user_id: contact_id, contact_id: user_id) unless

#       User.find(user_id).connections.pluck(:contact_id).include?(contact_id) || contact_id == user_id
#   end
#   (1..100).to_a.shuffle.take(1).each do |contact_id|
#     ConnectionRequest.create!(user_id: user_id, contact_id: contact_id) unless
#       User.find(user_id).connections.pluck(:contact_id).include?(contact_id) || contact_id == user_id || ConnectionRequest.where(contact_id:
#         contact_id, user_id: user_id)
#   end
# end
# puts 'connection requests created.'


# # creating community requests
# puts 'Creating 1 request to join community per user...'
# (1..100).to_a.each do |user_id|
#   (1..30).to_a.shuffle.take(1).each do |community_id|
#     CommunityRequest.create!(user_id: user_id, community_id: community_id) unless CommunityMembership.where(member_id: user_id, community_id: community_id)
#   end
# end
# puts 'community requests created.'
