class Deedveloper::Scraper
    attr_accessor :doc, :detail_doc

    def initialize(user_job, user_location, user_salary, user_radius, user_experience)
        # performs first round of gets/scraping operations upon intialization
        @doc = Nokogiri::HTML(open("http://www.indeed.com/jobs?as_and=#{user_job}&jt=all&st=&sr=&as_src=&salary=#{user_salary}&radius=#{user_radius}&l=#{user_location}&explvl=#{user_experience}&fromage=any&limit=50&sort=&psf=advsrch", :allow_redirections => :all))
    end

    def scrape_jobs
        doc.css('div.jobsearch-SerpJobCard').each do |job_card|
            j = Deedveloper::Job.new
            j.title = job_card.search("a.jobtitle").text.strip
            j.company = job_card.search("span.company").text.strip
            j.location = job_card.search("span.location").text.strip
            j.when_posted = job_card.search("span.date").text.strip
            if j.location.empty?
                j.location = job_card.search("div.location").text.strip 
            end
            if j.when_posted.empty?
               j.when_posted = job_card.search("span.sponsoredGray").text.strip
            end
            j.job_url = "https://indeed.com" + job_card.search("div.title a").first["href"]
        end
    end

    def self.scrape_detail(input)
        target_job = Deedveloper::Job.all[input.to_i-1]
        @detail_doc = Nokogiri::HTML(open(target_job.job_url, :allow_redirections => :all))
        # TODO: format target_job.description so that it's more readable.
        # target_job.description = @detail_doc.search("div.jobsearch-JobComponent-description").text
        target_job.salary = @detail_doc.search("div.jobsearch-JobMetadataHeader").text.strip
        if target_job.salary.empty?
            target_job.salary = "No salary info available"
        end
    end
end