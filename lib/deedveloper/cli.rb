class Deedveloper::CLI
    
    def call
        #displays welcome message and calls list_jobs/sort
        puts "Get you a job, son! Grab some coffee and check out these employment opportunities..."
        list_jobs
        sort
        goodbye
    end

    def list_jobs
        #get jobs from scraper and puts them 
        @jobs = Deedveloper::Job.get_jobs
        @jobs.each.with_index(1) do |job, i|
            puts "#{i}. #{job.title}, #{job.company}, #{job.location}, $#{job.salary}"
        end
    end

    def sort 
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
        #formats the specific job information
        puts  @jobs[input.to_i-1].title,  @jobs[input.to_i-1].company, @jobs[input.to_i-1].description, @jobs[input.to_i-1].website
    end

    def goodbye
        #displays exit message
    end
end