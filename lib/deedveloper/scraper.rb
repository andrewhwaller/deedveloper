require_relative "./joblist"
require 'nokogiri'

class JobScraper
    attr_accessor :joblist, :doc

    def initialize
        @joblist = joblist
        @doc = Nokogiri::HTML(open("https://www.indeed.com/jobs?as_and=junior+ruby+developer&as_phr=&as_any=&as_not=&as_ttl=&as_cmp=&jt=all&st=&as_src=&salary=&radius=25&l=Austin%2C+TX&fromage=any&limit=50&sort=&psf=advsrch"))
    end

    def joblist
        @joblist
    end

    def scrape
        scrape_jobs
    end

    def scrape_jobs
        @doc.search("jobsearch-SerpJobCard row result clickcard").each do |job_card|
            j = Job.new
            j.title = job_card.search("h2 a").text.strip
            j.company = job_card.search("span.company").text.strip
            j.location = job_card.search("span.location").text.strip
            j.when_posted = job_card.search("span.date").text.strip

        @joblist << j
        end
    end
end