namespace :db do
    desc 'Clear all sessions'
    task sessions: :environment do
      ActiveRecord::SessionStore::Session.delete_all
      puts 'All sessions have been cleared.'
    end
end