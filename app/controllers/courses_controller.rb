class CoursesController < ApplicationController
    def show
        render(:layout => "internal.html.erb")
    end 

    def index
        @course = Course.all
        render(:layout => "internal.html.erb")
    end

    def create
        @course = Course.create(course_params)
        redirect_to "/Course/new"
    end

    def add  
        current_user.courses << Course.find(params[:course])
        flash[:info] = "Succesfully Enrolled in #{Course.find(params[:course]).name}"
 
        redirect_to "/users/#{current_user.id}"
    end

    def new
        @course = Course.new
        render(:layout => "internal.html.erb")
    end

    def create
        @course = Course.new(course_params)

        if @course.save
            current_user.admin.courses << @course
            redirect_to "/users/#{current_user.id}"
        else
            render('new', :layout => "internal.html.erb")
        end
    end

    private
        def course_params
            params.require(:course).permit(:class_number, :name)
        end
end