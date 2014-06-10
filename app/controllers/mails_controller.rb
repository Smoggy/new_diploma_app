class MailsController < ApplicationController

	def index
		@tasks = Task.all
		@subjects = Subject.all
		@task_reports = TaskReport.all
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
		emails = Mail.all.select { |email| email.subject.eql? task.title }


  			emails.each do |email|
  				task_report = @task_reports.joins(:student).where("'students'.'email' = ?", email.from.first).first
  				task_report.update(status: 1) if task_report
  			end
		redirect_to mails_index_path
	end


	protected


end
