require_relative "./job"
require 'nokogiri'
require 'open-uri'

class JobScraper
    attr_accessor :doc

    def initialize
        @doc = Nokogiri::HTML(open("https://www.indeed.com/jobs?as_and=Ruby+Software+Developer&as_phr=&as_any=&as_not=&as_ttl=&as_cmp=&jt=fulltime&st=&sr=directhire&as_src=&salary=&radius=25&l=Austin%2C+TX&fromage=15&limit=50&sort=&psf=advsrch"))
    end

    def scrape_jobs
        doc.css('div.jobsearch-SerpJobCard').each do |job_card|
            j = Job.new
            j.title = job_card.search("a.jobtitle").text.strip
            # j.title = "Sample Title"
            j.company = job_card.search("span.company").text.strip
            # j.company = "Sample Company"
                # if job_card.search("div.location")
                #     j.location = job_card.search("div.location").text.strip
                # elsif job_card.search("span.location")
                #     j.location = job_card.search("span.location").text.strip
                # else j.location = "location unknowns"
                # end
            if job_card.css("span.location")
                j.location = job_card.css("span.location").text.strip
            else j.location = "Sponsored"
                end
            # j.when_posted = job_card.search("span.date").text.strip
            if job_card.search("span.date")
                j.when_posted = job_card.search("span.date").text.strip
                end
            end 
        Job.all << j
        end
    end