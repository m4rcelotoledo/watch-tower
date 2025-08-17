# frozen_string_literal: true

namespace :db do
  desc 'Refresh collations for all configured databases'
  task refresh_collations: :environment do
    configs = ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).presence ||
              ActiveRecord::Base.configurations.configs_for

    configs.each do |config|
      db_name = config.database
      quoted_db = ActiveRecord::Base.connection.quote_table_name(db_name)
      puts "🔄 Refreshing collation for database: #{db_name}"
      ActiveRecord::Base.connection.execute("ALTER DATABASE #{quoted_db} REFRESH COLLATION VERSION;")
      puts "✅ Collation refreshed for #{db_name}"
    end
  end
end
