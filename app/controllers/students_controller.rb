class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid 
 
    def index 
        render json: Student.all
    end

    def show
        render json: show_student = Student.find_by!(id: params[:id])
    end

    def create
       render json: new_student = Student.create!(student_params), status: :ok 
    end

    def update
        update_student = Student.find_by!(id: params[:id])
        update_student.update!(student_params)
        render json: update_student, status: :accepted
    end
    
    def destroy
       delete_student = Student.find_by!(id: params[:id]).destroy
       head :no_content
    end
end


private

def student_params 
    params.permit(:name, :major, :age, :instructor_id) #passing the instructor ID  because student needs an association with an instructor
end

def not_found_error(e)
    render json: {error: e.record.errors.full_messages}, status: :not_found
end

def record_invalid(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
end


