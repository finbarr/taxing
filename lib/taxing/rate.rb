require "csv"
require "httparty"

class Taxing::Rate
  include HTTParty
  base_uri "https://s3-us-west-2.amazonaws.com/taxrates.csv"

  STATES = ["AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"].freeze

  def self.all(t=Time.now)
    STATES.flat_map do |state_name|
      state(state_name, t)
    end
  end

  def self.state(state_name, t=Time.now)
    raise "invalid state" unless STATES.include?(state_name)
    raw = get("/TAXRATES_ZIP5_#{state_name}#{t.year}#{t.month}.csv").body
    skipped = false
    rates = []
    CSV.parse(raw).each do |row|
      unless skipped
        skipped = true
        next
      end
      rates << {
        state: row[0],
        zip_code: row[1],
        tax_region_name: row[2],
        tax_region_code: row[3],
        combined_rate: row[4],
        state_rate: row[5],
        county_rate: row[6],
        city_rate: row[7],
        special_rate: row[8]
      }
    end
    rates
  end
end
