class Distant::MailsController < DistantController

	def index
		@tasks = Task.where(grade: "distant", semester: @semester.name)
		@subjects = Subject.where(title: ["Математика","Химия","Биология","Физика"])
		if params[:format]
			@current_task = Task.find_by_id params[:format]
			@task_reports =@current_task.task_reports.includes(:student)
		else
			@task_reports = TaskReport.where.not(grade: "11")
		end
	end

	def send_task
		@tasks = Task.where(grade: "distant", semester: @semester.name)
		@subjects = Subject.where(title: ["Математика","Химия","Биология","Физика"])
	end

	def send_mail
		@task  =Task.find_by_id params[:task][:id]
		@subject = Subject.find_by_id params[:subject][:id]
		task_reports, threads =[], []
		@subject.students.where(semester: @semester.name).where.not(grade: "11").each do |student|
			threads << Thread.new do
				TaskMailer.send_task(@task, student).deliver
				task_report = TaskReport.new(task: @task, student: student, grade: student.grade)
				task_report.save
				ActiveRecord::Base.connection.close
			end
		end

		threads.each &:join
		redirect_to distant_mails_index_path
	end

	def receive
		task = Task.find_by_id params[:task][:id]
		@task_reports = task.task_reports
		emails = Mail.all.select { |email| email.subject.include? task.title }
		threads = []
  		emails.each do |email|
  			threads << Thread.new do 
	  			task_report = @task_reports.joins(:student).where("students.email = ?", email.from.first).first
	  		
	  			if task_report
	  				task_report.status =  1
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
	  			ActiveRecord::Base.connection.close
	  		end
  		end
  		threads.each &:join
		redirect_to distant_mails_index_path(task)
	end

	def download_report

		tr = TaskReport.find_by_id(params[:report_id])
		send_file(tr.report_file.path , filename: tr.report_file_file_name, type: tr.report_file_content_type)
	end


	protected


end
