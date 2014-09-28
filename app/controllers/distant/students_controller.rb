class Distant::StudentsController < DistantController

	def new
		@student = Student.new
		@subjects = Subject.where(title: ["Математика","Химия","Биология","Физика", "Информация"])
	end

	def create
		@student = Student.new student_params
		@student.semester = @semester.name
		subjects = Subject.where(id: params[:subject_ids])
		subjects.each do |subject|
			@student.subjects << subject
		end

		if @student.save
			redirect_to distant_students_path
		else
			render 'new'
		end
	end

	def edit
		@student = Student.find params[:id]
		@subjects = Subject.where(title: ["Математика","Химия","Биология","Физика", "Информация"])
	end

	def update
		@student = Student.find params[:id]
		subjects = Subject.where(id: params[:subject_ids])
		subjects.each do |subject|
			@student.subjects << subject
		end
		@student.update student_params
		if @student
			redirect_to distant_students_path
		else
			render 'edit'
		end
	end

	def index
		unless params[:student_ids]
			@students = Student.where(semester: @semester.name).where.not(grade: "11")
			@subjects = Subject.where(title: ["Математика","Химия","Биология","Физика"])
			@student_ids = @students.map {|s| s.id }
		else
			@students = Student.where(id: params[:student_ids])
			@subjects = Subject.where(title: ["Математика","Химия","Биология","Физика", "Информация"])
			@student_ids = params[:student_ids]
		end
	end

	def show

	end

	def filter
		if params[:subject][:id].present?
			@students = Student.joins(:subjects).where("semester = ? and subjects.id = ?",@semester.name, params[:subject][:id]).where.not(grade: "11")
			@student_ids = @students.map { |s| s.id }
		else
			@students = Student.where(semester: @semester.name).where.not(grade: "11")
			@student_ids = @students.map {|s| s.id }
		end
		@subjects = Subject.where(title: ["Математика","Химия","Биология","Физика", "Информация"])
		render 'index'
	end

	def delete
		@student = Student.find(params[:student_id])
	end

	def destroy
     	@student = Student.find(params[:id])
     	@student.destroy
     	redirect_to distant_students_path(student_ids: params[:student_ids])
	end

	def xls_index
		package = Axlsx::Package.new
   		workbook = package.workbook
    	@students = Student.where(id: params[:student_ids])
    	workbook.add_worksheet(name: "Студенты") do |sheet|
     		sheet.add_row ["ФИО Студента", "Email", "Адрес", "Skype","Телефон","Школа" ,"Класс","Предметы"]
     		@students.each do |s|
     			subjects = s.subjects.map { |s| s.title}.join(", ")
        		sheet.add_row [s.full_name, s.email, s.address, s.skype ,s.phone, s.school,s.grade, subjects]
      		end
    	end
    	package.serialize "Basic.xlsx"
    	send_file("#{Rails.root}/Basic.xlsx", filename: "Basic.xlsx", type: "application/vnd.ms-excel")
	end

	protected 
		def student_params
			params.require(:student).permit(:first_name, :last_name, :email, :phone, :address, :school, :grade, :skype)
		end
end
