class SemestersController < ApplicationController

	def new
		@semester = Semester.new
		@semesters = Semester.all
	end

	def create
		Semester.update_all(active: false)
		unless params[:semester][:id]
			@semester = Semester.new semester_params
		else
			@semester = Semester.find(params[:semester][:id])
		end

		@semester.active = true
		@semester.save
		redirect_to root_path
	end


	protected 

	def semester_params
		params.require(:semester).permit(:name)
	end
end
