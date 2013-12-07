require "stringex"


class Blog < Thor



	desc "post", "Create a new post"
	method_option :link, :default => nil
	method_option :editor, :default => "vim"
	def post(*title)

		title = title.join(" ")
		time = Time.now
		slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
		filename = "_posts/#{time.strftime('%Y-%m-%d')}-#{slug}.markdown"

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



	desc "up", "Start a server and open the site in your browser"
	def up
		system("jekyll serve -w &")
		system("sleep 3")
		system("open http://localhost:4000")
	end



end
