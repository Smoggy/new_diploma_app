class Task < ActiveRecord::Base
	has_attached_file :task_file
	has_many :task_reports

	do_not_validate_attachment_file_type :task_file
end
