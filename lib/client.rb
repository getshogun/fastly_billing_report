# frozen_string_literal: true

require 'fastly'

module Client
  class << self
    FASTLY_API_KEY = ENV.fetch('FASTLY_API_KEY')

    def new
      Fastly.new(api_key: FASTLY_API_KEY)
    end
  end
end
