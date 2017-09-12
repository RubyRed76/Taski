class Task < ActiveRecord::Base
  belongs_to :project

  # Implementing callbacks to check if task is completed and update Project percent
  # Complete IN that project EVERY time the task is saved

  after_save :update_percent_complete if :mark_completed?
  #need a Scope to let us call the .completed below
  scope :completed, -> { where(completed: true) }
  


  ##############################################################33
  mount_uploader :task_file, TaskFileUploader
  ###############################################################

  #Create Methods for this
  def mark_completed?
  	self.completed == true
  	#The only way this will come back as true is if this instance of "task" is marked as completed.
  	#****If not, this will come back as false, and then the after_save method will never be called.****
  end

  def update_percent_complete
    ################DEBUGGING: ###################
    puts "*" * 500
    puts "Beginning of callback"
    ################Debugging  ###################

  	#This is the method that will be run after save, IF mark completed comes back as true!
  	#In Ruby, methods will come back as true if they are not "nil" and not "false"
  	# Logic involved here in a mini-algorithm
  	project = Project.find(self.project_id)
  	# DB query that looks to see through the project table and finds whatever project that task 
  	# is associated with.  

  	#That's finding the project and it's going to store in a local variable "project".
  	count_of_completed_tasks = project.tasks.completed.count
  	#This variable will find all the tasks associated with this specific Project, 
  	# and count the completed ones.  
  	#This completed needs to grab a count of all the tasks so I need to put a scope up under the about_save

  	#We also need a count of total tasks
  	count_of_total_tasks = project.tasks.count
  	#And now we're actually going to call our Counter class set in Models folder
  	project.update!(percent_complete: Counter.calculate_percent_complete(count_of_completed_tasks, count_of_total_tasks))
  	#Counter will pass in count_of_completed_tasks and count_of_total_tasks
    ################DEBUGGING: ###################
    puts "&" * 500
    puts "END of callback"
    ################Debugging  ###################
  end

end
