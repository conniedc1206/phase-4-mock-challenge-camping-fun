class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    # GET /campers (id, name, age) campers#index
    def index
        campers = Camper.all
        render json: campers, status: :ok
    end

    # GET /campers/:id (id, name, age, activities) campers#show
    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperActivitySerializer
    end

    # POST /campers (accepts name and age) campers#create
    def create
        new_camper = Camper.create!(camper_params)
        render json: new_camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end