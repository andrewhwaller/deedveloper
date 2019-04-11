require 'nokogiri'
require 'open-uri'

class Scraper
    attr_accessor :doc, :detail_doc, :user_job, :user_location, :user_salary, :user_radius

    def initialize
        get_user_job
        get_user_location
        get_user_radius
        get_user_salary
        @doc = Nokogiri::HTML(open("http://www.indeed.com/jobs?as_and=#{user_job}&jt=all&st=&sr=&as_src=&salary=#{user_salary}&radius=#{user_radius}&l=#{user_location}&fromage=any&limit=50&sort=&psf=advsrch", :allow_redirections => :all))
    end

    def get_user_job
        puts "What sort of job would you like to search for?"
        @user_job = gets.strip.downcase
    end

    def get_user_location
        puts "What location would you like to search for?"
        @user_location = gets.strip.downcase
    end

    def get_user_salary
        puts "What is the yearly salary or salary range that you're looking for? Examples: $65,000; 65-85k, 65k, or 65000.","(Optional: leave blank to continue.)"
        @user_salary = gets.strip
    end

    def get_user_radius
        puts "What is your desired search radius in miles?"
        @user_radius = gets.strip
    end

    def scrape_jobs
        doc.css('div.jobsearch-SerpJobCard').each do |job_card|
            j = Job.new
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
        target_job = Job.all[input.to_i-1]
        @detail_doc = Nokogiri::HTML(open(target_job.job_url, :allow_redirections => :all))
        # TODO: format target_job.description so that it's more readable.
        # target_job.description = @detail_doc.search("div.jobsearch-JobComponent-description").text
        target_job.salary = @detail_doc.search("div.jobsearch-JobMetadataHeader").text.strip
        if target_job.salary.empty?
            target_job.salary = "No salary info available"
        end
    end
end