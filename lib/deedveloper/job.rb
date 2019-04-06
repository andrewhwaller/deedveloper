class Deedveloper::Job

    attr_accessor :title, :company, :location, :salary, :description, :website

    def latest_jobs
        self.get_jobs
    end

    def self.get_jobs
        jobs = []
        job_1 = self.new
        job_1.title = "Junior Rubyist"
        job_1.company = "Software Company"
        job_1.location = "Austin, TX"
        job_1.salary = "75000"
        job_1.description = "desc"
        job_1.website = "url"
    
        job_2 = self.new
        job_2.title = "Front-End Dev"
        job_2.company = "Other Company"
        job_2.location = "Austin, TX"
        job_2.salary = "80000"
        job_2.description = "desc"
        job_2.website = "url"
    
        [job_1, job_2]
    end
end 