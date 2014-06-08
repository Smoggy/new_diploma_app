# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


math = Subject.create(
	title: "mathematics"
	)

history = Subject.create(
	title: "history"
	)

first_student = Student.create(
	first_name: "first",
	last_name: "Student",
	email: "avatar145@ukr.net",
	)

second_student = Student.create(
	first_name: "second",
	last_name: "Student",
	email: "avatar145@mail.ru"
	)


third_student = Student.create(
	first_name: "third",
	last_name: "Student",
	email: "departed07@mail.ru"
	)

first_student.subjects << math
second_student.subjects << history << math
third_student.subjects << history
first_student.save
second_student.save
third_student.save