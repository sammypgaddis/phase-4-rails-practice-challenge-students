class InstructorsController < ApplicationController
    def index 
        render json: Instructor.all
    end

    def show 
        found_instructor = Instructor.find_by(id: params[:id])
        if found_instructor
            render json: found_instructor
        else 
            render json:  {errors: "Instructor not found"} , status: :not_found
        end
    end

    def create 
        new_instructor = Instructor.create( name: params[:name] )
        if new_instructor
            render json: new_instructor, status: :created
        else 
            render json: { errors: new_instructor.errors.full_messages }, status: :unprocessable_entity
        end
    end 

    def update
        update_instructor = Instructor.find_by(id: params[:id])
         update_instructor.update(update_instructor_params)
            if update_instructor
                render json: update_instructor
            else
                render json: { errors: update_instructors.errors.full_messages }, status: :not_found
            end
    end

    def destroy
        delete_instructor = Instructor.find_by(id: params[:id])
        if delete_instructor
            # delete_instructor.students.destroy <== if we were asked to destroy students associated with specific teachers
            delete_instructor.destroy
        else
            render json: {errors: "NO ONE DIES TODAY"}, status: :not_found
        end
        
    end

    private 

    def update_instructor_params 
        params.permit( :name )
    end 
    
end
