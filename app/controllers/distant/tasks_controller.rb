class Distant::TasksController < DistantController
  def new
  	@task = Task.new
  end

  def index
  	@tasks = Task.where(grade: "distant", semester: @semester.name)
  end

  def create
  	@task = Task.new task_params
    @task.grade = "distant"
    @task.semester = @semester.name
    @task.save
  	redirect_to  distant_tasks_path
  end

  protected

  	def task_params
 	 params.require(:task).permit(:title, :task_file)
	end
end
