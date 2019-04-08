require_relative "./job"
require 'nokogiri'

class JobScraper
    attr_accessor :doc

    def initialize
        @doc = Nokogiri::HTML(open("https://www.indeed.com/jobs?as_and=junior+ruby+developer&as_phr=&as_any=&as_not=&as_ttl=&as_cmp=&jt=all&st=&as_src=&salary=&radius=25&l=Austin%2C+TX&fromage=any&limit=50&sort=&psf=advsrch"))
    end

    def scrape_jobs
        # @doc.search("jobsearch-SerpJobCard row result clickcard").each do |job_card|
            j = Job.new
            # j.title = job_card.search("h2 a").text
            j.title = "Sample Title"
            # j.company = job_card.search("span.company").text
            j.company = "Sample Company"
            # j.location = job_card.search("span.location").text
            j.location = "Sample Location"
            # j.when_posted = job_card.search("span.date").text
            j.when_posted = "Sample Date"

        Job.all << j
        # end
    end
end