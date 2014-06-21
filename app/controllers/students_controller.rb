class StudentsController < ApplicationController

	def new
		@student = Student.new
		@subjects = Subject.all
	end

	def create
		@student = Student.new student_params
		subjects = Subject.where(id: params[:subject_ids])
		subjects.each do |subject|
			@student.subjects << subject
		end

		if @student.save
			redirect_to students_path
		else
			render 'new'
		end
	end

	def index
		@students = Student.all
		@subjects = Subject.all
		@student_ids = @students.map {|s| s.id }
	end

	def show

	end

	def filter
		if params[:subject][:id].present?
			@students = Student.joins(:subjects).where("subjects.id = ?", params[:subject][:id])
			@student_ids = @students.map { |s| s.id }
		else
			@students = Student.all
			@student_ids = @students.map {|s| s.id }
		end
		@subjects = Subject.all
		render 'index'
	end

	def xls_index
		package = Axlsx::Package.new
   		workbook = package.workbook
    	@students = Student.where(id: params[:student_ids])
    	workbook.add_worksheet(name: "Студенты") do |sheet|
     		sheet.add_row ["ФИО Студента", "Email", "Адрес", "Телефон","Школа" ,"Предметы"]
     		@students.each do |s|
     			subjects = s.subjects.map { |s| s.title}.join(", ")
        		sheet.add_row [s.full_name, s.email, s.address, s.phone, s.school, subjects]
      		end
    	end
    	package.serialize "Basic.xlsx"
    	send_file("#{Rails.root}/Basic.xlsx", filename: "Basic.xlsx", type: "application/vnd.ms-excel")
	end

	protected 
		def student_params
			params.require(:student).permit(:first_name, :last_name, :email, :phone, :address, :school)
		end
end
