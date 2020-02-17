class Movie < ActiveRecord::Base
    def self.allratings
        ["G", "PG", "PG-13", "NC-17", "R"]
    end
end
