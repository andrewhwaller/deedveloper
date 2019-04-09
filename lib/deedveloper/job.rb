class Job
    attr_accessor :title, :company, :location, :when_posted, :job_url, :salary, :description

    @@all = []

    def initialize
        @title = title
        @company = company
        @location = location
        @when_posted = when_posted
        @@all << self
    end

    def self.all
        @@all
    end
end