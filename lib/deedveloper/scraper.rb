require_relative "./joblist"
require 'nokogiri'

class JobScraper
    attr_accessor :joblist, :doc

    def initialize
        @joblist = Joblist.new
        @doc = Nokogiri::HTML(open("https://www.indeed.com/jobs?as_and=junior+ruby+developer&as_phr=&as_any=&as_not=&as_ttl=&as_cmp=&jt=all&st=&as_src=&salary=&radius=25&l=Austin%2C+TX&fromage=any&limit=50&sort=&psf=advsrch"))
    end

    def scrape
        scrape_jobs
        @joblist
    end

    def scrape_jobs
        @doc.search("jobsearch-SerpJobCard row result clickcard").each do |job_card|
            j = Job.new
            j.title = job_card.search("h2 a").text.strip
            j.company = job_card.search("span.company").text.strip
            j.location = job_card.search("span.location").text.strip
            j.when_posted = job_card.search("span.date").text.strip

        @joblist.add_job(j)
        end
    end

    # def self.scrape_indeed
    #     doc.css('td#resultsCol').each do |job_info| 
    #         jobs = JobList.new
    #         job_title = doc.css("h2 a").text
    #         job_company = doc.css("span.company").text
    #         job_location = doc.css("span.location").text
    #         job_when_posted = doc.css("span.date").text
    #         jobs << {title: job_title, company: job_company, location: job_location, when_posted: job_when_posted}
    #     end
    # end
end