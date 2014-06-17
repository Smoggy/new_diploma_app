class TaskReport < ActiveRecord::Base
	has_attached_file :report_file
	belongs_to :task
	belongs_to :student

	enum status: { pending: 0, done: 1 }


	do_not_validate_attachment_file_type :report_file
end
