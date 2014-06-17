class TaskReport < ActiveRecord::Base

	belongs_to :task
	belongs_to :student

	enum status: { pending: 0, done: 1 }

end
