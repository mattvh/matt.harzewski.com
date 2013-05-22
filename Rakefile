require "rubygems"
require "stringex"


desc "Begin a new post in _posts"
task :post, :title, :link do |t, args|

    if args.title
        title = args.title
    else
        abort("Error: You must supply a title. Usage: rake post['New Post Title']")
    end

    create_post(args.title, args.link)

end



def create_post(title, link=nil)

    raise "Error: There doesn't seem to be a _posts directory here..." unless File.directory?("_posts")

    filename = "_posts/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.markdown"

    if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end

    puts "Creating new post: #{filename}"

    open(filename, 'w') do |post|
        post.puts "---"
        post.puts "layout: post"
        post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
        post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M')}"
        if link
             post.puts "external-url: #{link}"
        end
        post.puts "---"
    end

end