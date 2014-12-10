class MainController < ApplicationController
	
	def index
		
	end # / def
	
	def code 
		
	end # /def
	
	def compute
		rule = params[:rule].nil? ? 30 : params[:rule].to_i
		steps = params[:steps].nil? ? 20 : params[:steps].to_i
		cell = params[:cells].nil? ? '1'.to_s : params[:cells].to_s
		pretty = (params[:pretty] == "yes") ? true : false
	
		logger.debug (pretty) ? "yes" : "no"
	
		# set how wide the base of the triangle is going to be
		size = steps + cell.size + steps
	
		# place 0 padding arround the cell size equally on both sides
		line = cell.center(size, '0')
			# eg. 00000000000000000000100000000000000000000 
			# 		for '1' & size = 41 (20 + 1 + 20)
	
		output = "";
	
		# iterate over the number of steps
		steps.times do 
			# pretty print the line before it gets mutated in the next generation
			output += (pretty === true) ? line.tr('01', ' X') : line
			output += "<br>"
			
			# the cell size needs to widen in order to make the triangle, let's do it
			widened = line[0,1] + line + line[-1,1]
			# concats the left and right value appropriately to the origin line value
			# the new width is going to size + 2, in this case, 44
	
			# iterate over the characters in the line and mutate each member
			# limit to the size (42) to remove excesssive characters
			line = (0..size).map { |i|
				# Long Hand Notation
				w = widened[i,3] # position plus 2 chars after
				z = w.to_i(2) # int value from base 2 binary value
				x = rule[z] # value of the rule at that intereger index
				# set that to the value of the index within the string 
	
				# Short Hand Notation
				rule[widened[i,3].to_i(2)]
			}.join	# combine the individual mutated values together into
					# 	a string and assign as the new value of the line
			
		end # / times

		respond_to do |format| 
			format.html { 
				# Make vars accessible to template
				@output = output
				@rule = rule
				@steps = steps
				@cell = cell
				@pretty = pretty
			}
			format.json {
				render :json => {
					:output => output.html_safe, 
					:status => 200, 
					:rule => rule,
					:steps => steps,
					:cell => cell,
					:pretty => pretty
				}
			}
		end # / respond_t
	
	end # / def
	
end # / class
