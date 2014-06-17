class TasksController < ApplicationController
  def new
  	@task = Task.new
  end

  def index
  	@tasks = Task.all
  end

  def create
  	@task = Task.create task_params
  	redirect_to  tasks_path
  end

  protected

  	def task_params
 	 params.require(:task).permit(:title, :task_file)
	end
end
