cookbook_path [ 
                File.join(File.dirname(__FILE__), '..', "site-cookbooks"),
                File.join(File.dirname(__FILE__), '..', "cookbooks")
              ]
log_level :debug
file_store_path File.join(File.dirname(__FILE__), '..')
file_cache_path File.join(File.dirname(__FILE__), '..')
#role_path File.join(File.dirname(__FILE__), '..', "roles")
Chef::Log::Formatter.show_time = false

