require_relative "./job"
require 'nokogiri'
require 'open-uri'

class JobScraper
    attr_accessor :doc, :detail_doc

    def initialize
        @doc = Nokogiri::HTML(open("http://www.indeed.com/jobs?as_and=Ruby+Software+Developer&as_phr=&as_any=&as_not=&as_ttl=&as_cmp=&jt=fulltime&st=&sr=directhire&as_src=&salary=&radius=25&l=Austin%2C+TX&fromage=15&limit=50&sort=&psf=advsrch"))
    end

    def scrape_jobs
        doc.css('div.jobsearch-SerpJobCard').each do |job_card|
            j = Job.new
            j.title = job_card.search("a.jobtitle").text.strip
            j.company = job_card.search("span.company").text.strip
            j.location = job_card.css("span.location").text.strip
            j.when_posted = job_card.search("span.date").text.strip
            if j.location.empty?
                j.location = job_card.css("div.location").text.strip 
            end
            if j.when_posted.empty?
               j.when_posted = job_card.css("span.sponsoredGray").text.strip
            end
            # if j.company.include?("Indeed")
            #     j.job_url = "http://indeed.com"
            # else
            j.job_url = "http://indeed.com" + job_card.search("div.title a").first["href"]
            # end
        end
    end

    def self.scrape_detail(input)
        target_job = Job.all[input.to_i-1]
        @detail_doc = Nokogiri::HTML(open(target_job.job_url))
        target_job.description = @detail_doc.search("div.jobsearch-JobComponent-description icl-u-xs-mt--md")
    end
end