class Movie < ActiveRecord::Base
    def self.allratings
        @ratings = Array.new
        @ratings = ["G", "PG", "PG-13", "NC-17", "R"]
        return @ratings
    end
end
