class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    
    # GET /activities activities#index
    def index
        activities = Activity.all
        render json: activities, status: :ok
    end

    # DELETE /activities/:id activities#destroy
    def destroy
        activity = Activity.find(params[:id])
        activity.destroy
        head :no_content
    end

    private
    def render_not_found_response
        render json: { error: "Activity not found" }, status: :not_found
      end

end