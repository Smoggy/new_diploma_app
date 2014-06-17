class AttachmentToReport < ActiveRecord::Migration
  def change
  	add_attachment :task_reports, :report_file
  end
end
