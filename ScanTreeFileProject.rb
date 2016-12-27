#!/usr/bin/env ruby

class ServiceClass
	attr_accessor :dirPath
	attr_accessor :tree_symbol_dir
	attr_accessor :tree_symbol_file 
	
	# Costructor class
	def initialize() 
		@dirPath = ARGV[0]
		@tree_symbol_dir = ""
		@tree_symbol_file = ""
	end
	
	# Function to print path dir target
	def print_dir_target
		puts "DIR PATH: #{@dirPath}"
	
	end
	
	# Read and print structure project class
	def create_classes_tree 
		print_content_dir(@dirPath)
	end
	
	# Print struct classes 
	def print_content_dir(dirPath) 
		contentDirPath = dirPath + "/*"
		# remove root path to print
		stringDirToPrint = contentDirPath.clone #clone path
		stringDirToPrint.sub!(@dirPath, "<project_root>") 
		#increase chars to render
		@tree_symbol_dir += "--"
		@tree_symbol_file += "  "
		#print a console 
		puts @tree_symbol_dir + "  " + stringDirToPrint
		#instantiate file
		file = Dir[contentDirPath]
		#fetch eanch item
		file.each do |file_path|
			#remove root path to print
			stringFileToPrint = file_path.clone #clone path
			stringFileToPrint.sub!(@dirPath, "<project_root>") 
			#print a console
			puts @tree_symbol_file + "|_" + stringFileToPrint
			#check if file is directory
			if File.directory? file_path 
				#if directory is not FRAMEWORK file
				if !file_path.include? ".framework" #skip file frameworks
					#call recorsive method to scan dir
					print_content_dir(file_path)
				end
			end
		end
	end 

end

if __FILE__ == $0
	# instantiate service class
	service = ServiceClass.new
	# print dir target
	service.print_dir_target
	# crate structure classes project
	service.create_classes_tree
end