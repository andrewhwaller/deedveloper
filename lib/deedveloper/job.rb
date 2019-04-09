class Job
    attr_accessor :title, :company, :location, :when_posted, :job_url, :salary

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

    def delete_blank
        delete_if do |k, v|
          (v.respond_to?(:empty?) ? v.empty? : !v) or v.instance_of?(Job.all) && v.delete_blank.empty?
        end
      end
end