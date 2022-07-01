module Api
  class ApplicationController < ActionController::API
    before_action :doorkeeper_authorize!
    include Response
    include ExceptionHandler
    # equivalent of authenticate_user! on devise, but this one will check the oauth token

    private

    # helper method to access the current user from the token
    def current_user
      @current_user ||= Student.find_by(id: doorkeeper_token[:resource_owner_id])
    end
  end
end