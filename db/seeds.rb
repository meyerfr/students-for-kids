# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


districts = %w(Oberkassel Niederkassel Lörick Büderich Osterath Bilk Altstadt Unterbilk Oberbilk Flehe Fliegern Düsseltal Stockum Heerdt Rath Unterrath)

districts.each do |d|
  District.create(name: d)
end
