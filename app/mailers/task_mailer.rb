class TaskMailer < ActionMailer::Base
  default from: "test_mailer@ukr.net"

  def send_task task, student
  	@task = task
  	@student = student
  	attachments[File.basename(@task.task_file.path)] = File.read(@task.task_file.path, mode: 'rb')
  	#attachments['task.zip'] = File.read(@task.task_file.path)

  	mail(to: @student.email,
 			subject: @task.title
    )
  end
end
