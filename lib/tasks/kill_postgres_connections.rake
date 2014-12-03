task :kill_postgres_connections => :environment do
  db_name = "#{Rails.env}_db"
  sh = <<EOF
ps xa \
  | grep postgres: \
  | grep #{db_name} \
  | grep -v grep \
  | awk '{print $1}' \
  | xargs sudo kill
EOF
  puts `#{sh}`
end

task "db:drop" => :kill_postgres_connections
