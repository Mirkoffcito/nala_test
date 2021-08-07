class ApplicationController < ActionController::API
    include StateUpdater
    include VacationCreateHandler
    include ErrorHandler
end
