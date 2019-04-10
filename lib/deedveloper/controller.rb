require_relative "./scraper"
require_relative "./job"
require 'pry'

class Controller
    
    def initialize
        puts "Welcome to Deedveloper!"
        puts "You need a job, son! Grab some coffee and let's get this bread..."
        s = JobScraper.new
        s.scrape_jobs
    end
    
    def call
        list_jobs
        job_display
    end

    def list_jobs
        puts "Check out these jobs:"
        Job.all.each.with_index(1) do |job, i|
            puts "#{i}. #{job.title}, #{job.company}"
        end
    end

    def job_display
        input = nil
        while input != "exit"
            puts "Enter the number of a job to see more info! Type exit to end search or type list to see job listings again."
            input = gets.strip.downcase 
            if input.to_i > Job.all.count
                puts "There aren't that many jobs!"
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
        puts "Job title: #{Job.all[input.to_i-1].title}",
        "Company: #{Job.all[input.to_i-1].company}",
        "Location: #{Job.all[input.to_i-1].location}",
        "Post date: #{Job.all[input.to_i-1].when_posted}",
        "Indeed posting: #{Job.all[input.to_i-1].job_url}",
        "Salary: #{Job.all[input.to_i-1].salary}"
    end

    def reprompt
        puts "Please type list or exit to proceed."
    end

    def goodbye
        puts "Enjoy your coffee! See you later."
    end
end