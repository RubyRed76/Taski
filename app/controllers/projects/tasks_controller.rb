class Projects::TasksController < ApplicationController
	before_action :set_task, only: [:show, :edit, :update, :destroy]

	before_action :set_project, only: [:show, :new, :edit, :create, :update, :destroy]
  def show
  end

  def new
  	@task = Task.new
  end

  def edit
  	#I can leave blank because out :set_task  is all we need to do here
  end

  def create
  	@task = Task.new(task_params)
  	@task.project_id = @project.id

  	respond_to do |format|
  	#want this to respond to both HTML and JSON, and I also want a conditional if the task works or if there is a problem saving.
  		if @task.save
  			# if everything is okay....(passes validations...)
  			format.html { redirect_to project_url(@task.project_id), notice: "Task was created successfully!" }
  			#... Format HTML, and we can pass some options, go to the task that was created, send a notice...
  			format.json { render :show, status: :created, location: @task }
  			#Format JSON in case we want to pass this to an API

  		else #that's if EVERYTHING worked!  But if not...
  			#We also want to catch what happens in THAT case as well
  			format.html { render :new }
  			format.json { render json: @task.errors, status: :unprocessable_entity } #... because if you're sending this Via an API, what's going to happen is you want to tell the corresponding system what's happening (IE. if it was successful or had problems, status is very important)

  		end
  	end
  end

  def update 
  	#Update action will already know about the task.  Don't need @task = Task.new

  	respond_to do |format|
  	#want this to respond to both HTML and JSON, and I also want a conditional if the task works or if there is a problem saving.
  		if @task.update(task_params)
  			# if everything is okay....(passes validations...)
  			format.html { redirect_to project_url(@task.project_id), notice: "Task was updated successfully!" }
  			#... Format HTML, and we can pass some options, go to the task that was created, send a notice...
  			format.json { render :show, status: :created, location: @task }
  			#Format JSON in case we want to pass this to an API

  		else #that's if EVERYTHING worked!  But if not...
  			#We also want to catch what happens in THAT case as well
  			format.html { render :edit }
  			format.json { render json: @task.errors, status: :unprocessable_entity } #... because if you're sending this Via an API, what's going to happen is you want to tell the corresponding system what's happening (IE. if it was successful or had problems, status is very important)

  		end
  	end
  end


  def destroy

  	@task.destroy
  	respond_to do |format|
  		format.html { redirect_to project_url(@task.project_id), notice: "Task was deleted!" }
 				#This is finding the project because if task is deleted, we don't have a task to go to!
 				format.json { head :no_content }
 		end
  end


  #Now to create the :set_task that we mentioned earlier
  private
  	def set_task
  		@task = Task.find(params[:id])
  		#Give this an instance variable @task, = Task.find, find from the params.  What this will do when we say params[:id], is FIND The params of that page.  So if you go into the show page for example, you're going to have tasks/15.  It's going to look at the 15 number, put that as an arguement in the "find" method query, and it's going to put THAT in the instance variable!  From there, because we have the before_action, we're making it available to the show method, update, edit and destroy

  		#in Rails Console, if I do a search for Task.find(1), this will bring us the info for the first task
  	end

  	def set_project
  		#Here it's going to be a bit different.  It's not going to be id, but project_id
  		# This is going to go into the URL structure (ie.  .com/projects/5/tasks/2)
  		@project = Project.find(params[:project_id])
  		# This will take that project_id (projects/5) of "5" find that specific project, 
  		# store it in the instance variable and make it available  in the methods above!
  	end



  	def task_params
  		#This is where we will take the different attributes we want the forms to be able to take in.  So here we want to pass in the params method and say require :task (table name) call the .permit method on it, which takes a number of arguements (any that we want to white list), from our schema.rb file: I want to be able to permit:
  		params.require(:task).permit(:title, :description, :project_id, :completed, :task_file)
  		#... want tot take the task_file for when we actually integrate our file uploads
  	end

end
