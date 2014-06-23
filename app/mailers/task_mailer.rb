class TaskMailer < ActionMailer::Base
  default from: "shdo@karazin.ua"

  def send_task task, student
  	@task = task
  	@student = student
  	attachments[File.basename(@task.task_file.path)] = File.read(@task.task_file.path, mode: 'rb')

  	mail(to: @student.email,
 			subject: @task.title
    )
  end
end
