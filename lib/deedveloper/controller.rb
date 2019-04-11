require_relative "./scraper"
require_relative "./job"

class Controller
    
    def call
        #welcomes the user and initiates search
        puts "","░▒▓ Welcome to DEEDVELOPER, an Indeed.com search engine in Ruby! ▓▒░"
        puts "You need a job, son! Grab some coffee and let's get this bread...",""
        search
    end

    def search
        #calls first level scraper method, pulls the resulting data, and displays it for user interaction
        scraper = Scraper.new
        scraper.scrape_jobs
        list_jobs
        display_detail
    end

    def list_jobs
        #formats first level job information and displays it for the user
        puts "Check out these jobs:"
        Job.all.each.with_index(1) do |job, i|
            puts "#{i}. #{job.title} ◦ #{job.company}",
            ""
        end
    end

    def display_detail
        #accepts user input, displays level two job information for selected job, and provides other options for user interaction: exit, list, and search
        input = nil
        while input != "exit"
            puts 'Enter the number of a job to see more info! Type "exit" to end search, "list" to see job listings again, or "search" to begin a new search.'
            input = gets.strip.downcase 
            if input.to_i > Job.all.count
                puts "There aren't that many jobs!"
            elsif input.to_i >= 1
                get_detail(input)
            elsif input == "list"
                list_jobs
            elsif input == "exit"
                goodbye
            elsif input == "search"
                puts "OK, let's search again!"
                # clears Job.all for repopulation by search method
                Job.all.clear
                search
            end
        end
    end

    def get_detail(input)
        #initiates further scraping and formats/displays additional job details for a user-selected job
        Scraper.scrape_detail(input)
        puts "","Job title: #{Job.all[input.to_i-1].title}",
        "Company: #{Job.all[input.to_i-1].company}",
        "Location: #{Job.all[input.to_i-1].location}",
        "Post date: #{Job.all[input.to_i-1].when_posted}",
        "Salary: #{Job.all[input.to_i-1].salary}",
        "Indeed posting: #{Job.all[input.to_i-1].job_url}",""
    end

    def goodbye
        puts "Enjoy your coffee! See you later."
        return exit
    end
end