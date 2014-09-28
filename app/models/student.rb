class Student < ActiveRecord::Base
	has_and_belongs_to_many :subjects, -> { uniq }
	has_many :task_reports
	validates :email, presence: true
	validates :first_name, presence: true
	default_scope { order(:last_name => :asc)}

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
		"#{last_name} #{first_name} "
	end

	def subject_titles
		subjects.pluck(:title).join(", ")
	end
end
