# frozen_string_literal: true

class Usage
  class << self
    def stats(months_ago = 1)
      months_ago.times.map do |n|
        month = n.months.ago
        stats = MonthlyUsage.stats(month)

        [month.strftime('%Y-%m'), stats]
      end.to_h
    end
  end
end
