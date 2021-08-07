class ApplicationController < ActionController::API
    include StateUpdater
    include VacationCreateHandler
end
