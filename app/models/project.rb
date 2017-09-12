class Project < ActiveRecord::Base
	#Controller is actually doing the logic for this right now, so 
	# we don't need code here for this to work.

	has_many :tasks

	after_initialize :set_defaults

	##################################
	#Temporarily turn OFF VALIDATIONS
	#Okay, now turn back on:
	validates_presence_of :title, :description, :percent_complete
	#validates_presence_of :description


	scope :almost_completed, -> { where('percent_complete > 75.0') }
	#Now we have this :almost_completed method which we can call from our ProjectsController
	scope :still_needs_more_work, -> { where('percent_complete < 75.0') }




	def set_defaults
		self.percent_complete ||= 0.0
	end


end
