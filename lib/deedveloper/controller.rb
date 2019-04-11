require_relative "./scraper"
require_relative "./job"

class Controller

    def initialize
        puts "Welcome to DEEDVELOPER, an Indeed.com search engine in Ruby!"
        puts "You need a job, son! Grab some coffee and let's get this bread...",""
        scraper = JobScraper.new
        scraper.scrape_jobs
    end
    
    def call
        list_jobs
        job_display
    end

    def list_jobs
        puts "Check out these jobs:"
        Job.all.each.with_index(1) do |job, i|
            puts "#{i}. #{job.title}, #{job.company}",
            ""
        end
    end

    def job_display
        input = nil
        while input != "exit"
            puts "Enter the number of a job to see more info! Type exit to end search or type list to see job listings again."
            input = gets.strip.downcase 
            if input.to_i > Job.all.count
                puts "There aren't that many jobs!"
                reprompt
            elsif input.to_i >= 1
                job_detail(input)
            elsif input == "list"
                list_jobs
            elsif input == "exit"
                goodbye
            end
        end
    end

    def job_detail(input)
        JobScraper.scrape_detail(input)
        puts "","Job title: #{Job.all[input.to_i-1].title}",
        "Company: #{Job.all[input.to_i-1].company}",
        "Location: #{Job.all[input.to_i-1].location}",
        "Post date: #{Job.all[input.to_i-1].when_posted}",
        "Salary: #{Job.all[input.to_i-1].salary}",
        "Indeed posting: #{Job.all[input.to_i-1].job_url}",""
    end

    def reprompt
        puts "Please type list or exit to proceed."
    end

    def goodbye
        puts "Enjoy your coffee! See you later."
    end
end