# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sophies = Venue.create(google_place_id: "ChIJAWqtshZawokRpoLRfZ9B0y4")
subway = Venue.create(google_place_id: "ChIJFdlGXhFawokR7lPqXwaGirc")
cafe_11 = Venue.create(google_place_id: "ChIJ0XYmYhFawokRF4L2czb2yK0")

rachel = Member.create(uid: 1234, name: "Rachel Bronstein")
einar = Member.create(uid: 5678, name: "Einar Stensson")
steven = Member.create(uid: 1010, name: "Steven Nunez")
sophie = Member.create(uid: 1126, name: "Sophie deBenedetto")
antoin = Member.create(uid: 9876, name: "Antoin Campbell")

Blacklist.create(venue: sophies, member: rachel)
Blacklist.create(venue: subway, member: einar)
Blacklist.create(venue: cafe_11, member: rachel)
