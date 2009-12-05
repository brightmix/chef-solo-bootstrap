cookbook_path [ 
                File.join(File.dirname(__FILE__), '..', "site-cookbooks"),
                File.join(File.dirname(__FILE__), '..', "cookbooks")
              ]
role_path File.join(File.dirname(__FILE__), '..', "roles")
log_level :debug
file_store_path File.join(File.dirname(__FILE__), '..')
file_cache_path File.join(File.dirname(__FILE__), '..')
Chef::Log::Formatter.show_time = false

