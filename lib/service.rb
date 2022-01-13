# frozen_string_literal: true

class Service
  class << self
    def find(id)
      all[id]
    end

    def all
      @all ||= Client.new.list_services.map do |service|
        [service.id, service.name]
      end.to_h
    end
  end
end
