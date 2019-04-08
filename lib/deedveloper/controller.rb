require_relative "./scraper"
require_relative "./job"

class Controller
    
    def initialize
        puts "Welcome to Deedveloper!"
        j = JobScraper.new
        j.scrape_jobs
    end
    
    def call
        #displays welcome message and calls list_jobs/sort
        puts "You need a job, son! Grab some coffee and let's get this bread..."
        job_display
        sort
        goodbye
    end

    def list_jobs
        #gets jobs from Job class and displays them 
        Job.all.each.with_index(1) do |job, i|
            puts "#{i}. #{job.title}, #{job.company}, #{job.location}, $#{job.when_posted}"
        end
    end

    def job_display
        #takes user input and displays info on specific job
        input = nil
        while input != "exit"
            puts "Enter the number of a job to see more info! Type exit to end search or type list to see job listings again."
            input = gets.strip.downcase
            if input.to_i > 0
                job_detail(input)
            elsif input == "list"
                list_jobs
            else
                puts "Please type list or exit to proceed."
            end
        end
    end

    def job_detail(input)
        #formats the specific job information accorind to user input
        puts Job.all[input.to_i-1].title,  Job.all[input.to_i-1].company, Job.all[input.to_i-1].location, Job.all[input.to_i-1].when_posted
    end

    def goodbye
        #displays exit message
        puts "Enjoy your coffee! See you later."
    end
end