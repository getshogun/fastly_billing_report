# frozen_string_literal: true

class MonthlyUsage
  class << self
    def stats(date)
      from = date.at_beginning_of_month.to_time.to_i
      to = date.end_of_month.to_time.to_i

      result = Client.new.usage(by_service: true, from:, to:)
      sum_all_regions(result['data'])
    end

    private

    def sum_all_regions(data)
      result = {}
      data.each_value do |region_stats|
        region_stats.each do |service_id, stats|
          service_name = Service.find(service_id)

          result[service_name] ||= { bandwidth: 0, requests: 0, compute_requests: 0 }
          result[service_name][:bandwidth] += stats['bandwidth']
          result[service_name][:requests] += stats['requests']
          result[service_name][:compute_requests] += stats['compute_requests']
        end
      end
      result
    end
  end
end
