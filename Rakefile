REMOTE_CHEF_PATH = "/etc/chef" # Where to find upstream cookbooks

desc "Test your cookbooks and config files for syntax errors"
task :test do
  Dir[ File.join(File.dirname(__FILE__), "**", "*.rb") ].each do |recipe|
    sh %{ruby -c #{recipe}} do |ok, res|
      raise "Syntax error in #{recipe}" if not ok
    end
  end

end

desc "Upload the latest copy of your cookbooks to remote server"
#task :upload => [:test]  do
task :upload do
  if !ENV["server"]
    puts "You need to specify a server rake upload server=whatever.com"
    exit 1
  end

  puts "* Upload your cookbooks *"
  sh "rsync -rlP --delete --exclude '.*' #{File.dirname(__FILE__)}/ #{ENV['server']}:#{REMOTE_CHEF_PATH}"
end

desc "Run chef solo on the server"
task :cook => [:upload] do
  if !ENV["server"]
    puts "You need to specify a server 'rake cook server=whatever.com'"
    exit 1
  end

  puts "* Running chef solo on remote server *"
  sh "ssh #{ENV['server']} \"cd #{REMOTE_CHEF_PATH}; chef-solo -l debug -c config/solo.rb -j config/chef.json \""
end

