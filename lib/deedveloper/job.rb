class Deedveloper::Job
    attr_accessor :title, :company, :location, :when_posted

    def self.latest_jobs
        #returns instances of job
        self.get_jobs
    end

    def self.get_jobs
        jobs = []
        
        jobs << self.scrape_indeed

        # job_1 = self.new
        # job_1.title = "Junior Rubyist"
        # job_1.company = "Software Company"
        # job_1.location = "Austin, TX"
        # job_1.salary = "75000"
        # job_1.description = "desc"
        # job_1.website = "url"
    
        # job_2 = self.new
        # job_2.title = "Front-End Dev"
        # job_2.company = "Other Company"
        # job_2.location = "Austin, TX"
        # job_2.salary = "80000"
        # job_2.description = "desc"
        # job_2.website = "url"
    
        # [job_1, job_2]
        jobs
    end

    def self.scrape_indeed
        doc = Nokogiri::HTML(open("https://www.indeed.com/jobs?as_and=junior+ruby+developer&as_phr=&as_any=&as_not=&as_ttl=&as_cmp=&jt=fulltime&st=&sr=directhire&as_src=&salary=&radius=25&l=Austin%2C+TX&fromage=any&limit=50&sort=&psf=advsrch"))

        job = self.new
        job.title = doc.search("h2.jobtitle").text
        job.company = doc.search("span.company").text
        job.location = doc.search("span.location").text
        job.when_posted = doc.search("span.date").text
        
        job
    end
end 