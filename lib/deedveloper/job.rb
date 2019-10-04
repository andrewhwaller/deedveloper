class Deedveloper::Job
    attr_accessor :title, :company, :location, :when_posted, :experience, :job_url, :salary, :description

    @@all = []

    def initialize
        @title = title
        @company = company
        @location = location
        @when_posted = when_posted
        @experience = experience
        @job_url = job_url
        @salary = salary
        @description = description
        @@all << self
    end

    def self.all
        @@all
    end
end