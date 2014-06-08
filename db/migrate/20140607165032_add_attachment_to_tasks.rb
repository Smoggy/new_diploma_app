class AddAttachmentToTasks < ActiveRecord::Migration
  def change
  	add_attachment :tasks, :task_file
  end
end
