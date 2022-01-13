# frozen_string_literal: true

require 'dotenv/load'
require 'active_support/all'
require 'csv'

require_relative 'client'
require_relative 'service'
require_relative 'monthly_usage'
require_relative 'usage'

class Report
  class << self
    def export(months = 1)
      stats = Usage.stats(months)
      write_csv(metric: :bandwidth, stats:)
      write_csv(metric: :requests, stats:)
      write_csv(metric: :compute_requests, stats:)
    end

    private

    def write_csv(metric:, stats:)
      dates = stats.keys.sort
      services = stats.values.map(&:keys).flatten.compact.uniq.sort

      rows = services.map do |service|
        row = [service]
        dates.each { |date| row << stats.dig(date, service, metric) || 0 }
        row
      end

      headers = ['service'] + dates
      CSV.open("#{metric}.csv", 'w', write_headers: true, headers:) do |csv|
        rows.each { |row| csv << row }
      end
    end
  end
end
