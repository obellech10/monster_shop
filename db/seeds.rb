# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.destroy_all
Item.destroy_all

lisa = User.create!(name: "Lisa", address: "24 25th Ave.", city: "Denver", state: "CO", zip: 80202, user_name: "lisa@gmail.com", password: "test", role: 2)
joe = User.create!(name: "Joe", address: "549 17th St.", city: "Miami", state: "FL", zip: 30305, user_name: "joe@gmail.com", password: "1234", role: 2)
mark = User.create!(name: "Mark", address: "33 Tree St.", city: "Charlotte", state: "NC", zip: 34356, user_name: "mark@gmail.com", password: "password", role: 2)

linda = User.create!(name: "Linda", address: "1331 20th St.", city: "Miami", state: "FL", zip: 80242, user_name: "bird@gmail.com", password: "fish", role: 0)
mary = User.create!(name: "Mary", address: "110 Tree Lane.", city: "There", state: "AL", zip: 12450, user_name: "snail@gmail.com", password: "toe", role: 0)
elma = User.create!(name: "Elma", address: "239 Maple Ave.", city: "Nowhere", state: "MA", zip: 80237, user_name: "red@gmail.com", password: "swim", role: 0)
nick = User.create!(name: "Nick", address: "5 Elm Ave.", city: "Where", state: "SD", zip: 23495, user_name: "blue@gmail.com", password: "shark", role: 0)
dan = User.create!(name: "Dan", address: "61 Vine Drive.", city: "Joy", state: "MD", zip: 22980, user_name: "green@gmail.com", password: "pizza", role: 0)
shannon = User.create!(name: "Shannon", address: "240 25th St.", city: "Maryknoll", state: "NY", zip: 55420, user_name: "yellow@gmail.com", password: "bread", role: 0)

ogre = lisa.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 15 )
giant = lisa.items.create!(name: 'Giant', description: "I'm a Giant!", price: 100, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 31 )
lamp = lisa.items.create!(name: 'Lamp', description: "I'm a Lamp!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 29 )
fish = lisa.items.create!(name: 'Fish', description: "I'm a Fish!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 43 )
chair = joe.items.create!(name: 'Chair', description: "I'm a Chair!", price: 3, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 21 )
bed = joe.items.create!(name: 'Bed', description: "I'm a Bed!", price: 6, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 300 )
car = joe.items.create!(name: 'Car', description: "I'm a Car!", price: 56, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 34)
horse = joe.items.create!(name: 'Horse', description: "I'm a Horse!", price: 23, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 63 )
tea_pot = mark.items.create!(name: 'Tea Pot', description: "I'm a Tea Pot!", price: 40, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 71 )
leaf = mark.items.create!(name: 'Leaf', description: "I'm a Leaf!", price: 21, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 11 )
desk = mark.items.create!(name: 'Desk', description: "I'm a Desk!", price: 11, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 28 )
shirt = mark.items.create!(name: 'Shirt', description: "I'm a Shirt!", price: 92, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 19 )

order_1 = Order.create!(user: linda, status: "pending")
order_2 = Order.create!(user: mary, status: "pending")
order_3 = Order.create!(user: elma, status: "pending")
order_4 = Order.create!(user: dan, status: "pending")
order_5 = Order.create!(user: nick, status: "pending")
order_6 = Order.create!(user: shannon, status: "pending")


order_items_1 = order_1.order_items.create!(item: ogre, price: ogre.price, quantity: 1)
order_items_2 = order_1.order_items.create!(item: giant, price: giant.price, quantity: 2)
order_items_3 = order_1.order_items.create!(item: lamp, price: lamp.price, quantity: 5)
order_items_4 = order_2.order_items.create!(item: fish, price: fish.price, quantity: 11)
order_items_5 = order_2.order_items.create!(item: bed, price: bed.price, quantity: 2)
order_items_6 = order_2.order_items.create!(item: car, price: car.price, quantity: 1)
order_items_7 = order_3.order_items.create!(item: horse, price: horse.price, quantity: 4)
order_items_8 = order_3.order_items.create!(item: tea_pot, price: tea_pot.price, quantity: 7)
order_items_9 = order_3.order_items.create!(item: leaf, price: leaf.price, quantity: 9)
order_items_10 = order_4.order_items.create!(item: desk, price: desk.price, quantity: 1)
order_items_11 = order_4.order_items.create!(item: shirt, price: shirt.price, quantity: 3)
order_items_12 = order_4.order_items.create!(item: ogre, price: ogre.price, quantity: 4)
order_items_13 = order_5.order_items.create!(item: giant, price: giant.price, quantity: 2)
order_items_14 = order_5.order_items.create!(item: lamp, price: lamp.price, quantity: 6)
order_items_15 = order_5.order_items.create!(item: fish, price: fish.price, quantity: 5)
order_items_16 = order_6.order_items.create!(item: bed, price: bed.price, quantity: 10)
order_items_17 = order_6.order_items.create!(item: car, price: car.price, quantity: 8)
order_items_18 = order_6.order_items.create!(item: horse, price: horse.price, quantity: 1)
