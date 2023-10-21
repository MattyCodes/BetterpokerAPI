module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def current_application_context
      # TODO: Handle context to be shared across AC connections.
      @current_application_context ||= nil
    end
  end
end
