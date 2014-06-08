class Task < ActiveRecord::Base
	has_attached_file :task_file

	do_not_validate_attachment_file_type :task_file
end
