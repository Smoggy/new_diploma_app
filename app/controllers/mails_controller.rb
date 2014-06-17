class MailsController < ApplicationController

	def index
		@tasks = Task.all
		@subjects = Subject.all
		if params[:format]
			@current_task = Task.find_by_id params[:format]
			@task_reports =@current_task.task_reports.includes(:student)
		end
	end

	def send_task
		@tasks = Task.all
		@subjects = Subject.all
	end

	def send_mail
		@task  =Task.find_by_id params[:task][:id]
		@subject = Subject.find_by_id params[:subject][:id]
		task_reports =[]
		@subject.students.each do |student|
			TaskMailer.send_task(@task, student).deliver
			task_reports << TaskReport.new(task: @task, student: student)
		end
		ActiveRecord::Base.transaction do
			task_reports.each { |tr| tr.save }
		end

		redirect_to mails_index_path
	end

	def receive
		task = Task.find_by_id params[:task][:id]
		@task_reports = task.task_reports
		emails = Mail.all.select { |email| email.subject.include? task.title }


  		emails.each do |email|
  			task_report = @task_reports.joins(:student).where("'students'.'email' = ?", email.from.first).first

  			if task_report
  				task_report.status=  1
  				attachment = email.attachments.first
  				if attachment
	  				file = StringIO.new(attachment.decoded)
	  				file.class.class_eval { attr_accessor :original_filename, :content_type }
	  				file.original_filename = attachment.filename
	  				file.content_type = attachment.mime_type
	  				task_report.report_file = file
	  			end
	  			task_report.save
  			end
  		end
		redirect_to mails_index_path(task)
	end


	protected


end
