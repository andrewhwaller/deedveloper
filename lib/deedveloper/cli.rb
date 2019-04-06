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
    end

    def job_detail(input)
        #formats the specific job information
    end

    def goodbye
        #displays exit message
    end
end