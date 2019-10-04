class Deedveloper::Controller
     
    def call
        #welcomes the user and initiates search
        puts "","░▒▓ Welcome to DEEDVELOPER, an Indeed.com search engine in Ruby! ▓▒░"
        puts "You need a job, son! Grab some coffee and let's get this bread...",""
        search
    end

    def search
        #calls first level scraper method, pulls the resulting data, and displays it for user interaction
        scraper = Deedveloper::Scraper.new(user_job, user_location, user_radius, user_experience, user_salary)
        scraper.scrape_jobs
        list_jobs
        display_detail
    end

    def user_job
        puts "What sort of job would you like to search for?"
        gets.strip.downcase
    end

    def user_location
        puts "What location would you like to search for?"
        gets.strip.downcase
    end

    def user_radius
        puts "What is your desired search radius in miles?"
        gets.strip
    end

    def user_experience
        puts 'What sort of experience level are you searching for? Type "entry level", "mid level", or "senior level."','(Optional: leave blank to continue.)'
        input = gets.strip.to_s
        if input.include?("entry")
            return "entry_level"
        elsif input.include?("mid")
            return "mid_level"
        elsif input.include?("senior")
            return "senior_level"
        else
            return nil 
        end
    end

    def user_salary
        #TODO: build logic that recognizes invalid input and reprompts user; invalid or irregular input can affect search results
        puts "What is the yearly salary or salary range that you're looking for? Examples: $65,000, 65-85k, 65k, or 65000.","(Optional: leave blank to continue.)"
        gets.strip
    end

    def list_jobs
        #formats first level job information and displays it for the user
        puts "Check out these jobs:"
        Deedveloper::Job.all.each.with_index(1) do |job, i|
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
            if input.to_i > Deedveloper::Job.all.count
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
                Deedveloper::Job.all.clear
                search
            end
        end
    end

    def get_detail(input)
        #initiates further scraping and formats/displays additional job details for a user-selected job
        Deedveloper::Scraper.scrape_detail(input)
        job = Deedveloper::Job.all[input.to_i-1]
        puts "","Job title: #{job.title}",
        "Company: #{job.company}",
        "Location: #{job.location}",
        "Post date: #{job.when_posted}",
        "Salary: #{job.salary}",
        "Indeed posting: #{job.job_url}",""
    end

    def goodbye
        puts "Enjoy your coffee! See you later."
        return exit
    end
end