class ApplicationController < ActionController::API
    include StateUpdater
    include VacationCreateHandler
    include ErrorHandler
    include AuthorizeApiRequest

    before_action :authorize_request
    before_action :error_handler, only: [:show, :update, :destroy, :index]
end
