class MailsController < ApplicationController

	def index
		
		@tasks = Task.all
		@subjects = Subject.all
	end

	

	def receive
		task = Task.find_by_id params[:task_id]
		task_reports = task.task_reports.includes(:students)
		emails = Mail.all.select { |email| email.subject.eql? task.title }

		ActiveRecord::Base.transaction do
  			emails.each do |email|
  				task_report = task_reports.where("student.email = ?", email.from.first).first
  				task_report.update(status: 1) if task_report
  			end
		end
		task_reports
	end


	protected


end
