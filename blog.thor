require "stringex"


class Blog < Thor



	desc "post", "Create a new post"
	method_option :link, :default => nil
	method_option :editor, :default => "subl"
	def post(*title)

		title = title.join(" ")
		time = Time.now
		filename = "_posts/#{time.strftime('%Y-%m-%d')}-#{title.to_url}.markdown"

		if File.exist?(filename)
			abort("#{filename} already exists!")
		end

		puts "Creating new post: #{filename}"
		open(filename, 'w') do |post|
			post.puts "---"
			post.puts "layout: post"
			post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
			post.puts "date: #{time.strftime('%Y-%m-%d %H:%M')}"
			if options[:link]
				post.puts "external-url: #{options[:link]}"
			end
			post.puts "---"
		end

		system(options[:editor], filename)

	end



end
