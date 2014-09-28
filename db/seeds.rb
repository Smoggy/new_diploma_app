# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = ["География","Информация","Математика", "Физика", "Биология", "Химия", "Английский Язык", "История Украины", "Всемирная история", "Украинская литература"]

names.each do |n|
	Subject.find_or_create_by title: n
end

Semester.find_or_create_by(
	name: "2014",
	active: true
)