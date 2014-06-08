class Student < ActiveRecord::Base
	has_and_belongs_to_many :subjects

	def self.find_by_subject subject
		joins(:subjects).where("subjects.title = ?", subject)
	end


	def self.send_task_for_subject subject
		students = self.find_by_subject subject
		task = Task.first
		students.each do |student|
			TaskMailer.send_task(task, student).deliver
		end
	end

	def full_name
		"#{first_name} #{last_name}"
	end
end
