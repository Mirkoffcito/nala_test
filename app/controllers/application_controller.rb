class ApplicationController < ActionController::API
    include StateUpdater
    include VacationCreateHandler
    include ErrorHandler

    before_action :error_handler, only: [:show, :update, :destroy, :index]
end
