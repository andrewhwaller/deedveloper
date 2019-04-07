class Joblist
    attr_accessor :jobs

    def initialize
        @jobs = []
    end

    def add_job(job)
        @jobs << job
    end

end