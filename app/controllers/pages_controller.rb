class PagesController < ApplicationController
  def contact
  end

  def about
  	@title = "My Cool Page"
  end

  def home
  	# @projects = Project.all.limit(10)
  	@projects = Project.all
  	#by placing this "instance" variable inside of this method,
  	# we now have Access to this INSIDE of the view!
  end




  def error
    #We don't need anything in here because we're not passing any values to "error"
  end

end
