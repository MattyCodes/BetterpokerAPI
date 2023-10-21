module ModelHelpers
  module Uuid
    def self.included(base)
      base.class_eval do
        before_save :set_uuid
      end
    end

    def set_uuid
      self.uuid ||= SecureRandom.uuid
    end
  end
end
