class StudentsController < ApplicationController

	def new
		@student = Student.new
		@subjects = Subject.all
	end

	def create
		@student = Student.new student_params
		subjects = Subject.where(id: params[:student][:subject_ids])
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
	end

	def show

	end

	protected 
		def student_params
			params.require(:student).permit(:first_name, :last_name, :email, :phone, :address, :school)
		end
end
