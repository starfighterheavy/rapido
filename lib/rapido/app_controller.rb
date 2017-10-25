require 'active_support'
require 'active_support/core_ext'

module Rapido
  module AppController
    extend ActiveSupport::Concern

    def index
      @resource_collection = resource_collection
    end

    def show
      @resource = resource
    end

    def new
      @new_resource = resource_class.new
    end

    def create
      new_resource = build_resource
      if new_resource.save
        redirect_to new_resource
      else
        flash[:error] = new_resource.errors.full_messages.join('. ')
        redirect_to new_resource
      end
    end

    def destroy
      resource.destroy
      redirect_to index_controller_path
    end

    def edit
      @resource = resource
    end

    def update
      resource.assign_attributes(resource_params)
      if resource.save
        redirect_to resource
      else
        flash[:error] = resource.errors.full_messages.join('. ')
        resource.reload
        redirect_to url_for([:edit, resource])
      end
    end

    private

    def scoped_url_for(action, owner, resource)
      begin
        url_for([action, owner, resource])
      rescue
        url_for([action, resource])
      end
    end
  end
end
