RSpec.configure do |config|
    # truncate the DB before every use
    config.before(:suite) do
        # except is essential for active-record, otherwise active-record's environment data is destroyed which causes errors
        DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata)
    end
    
    config.before(:each) do
        DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, js: true) do
        DatabaseCleaner.strategy = :truncation
    end
    
    config.before(:each) do
        DatabaseCleaner.start
    end
    
    config.after(:each) do
        DatabaseCleaner.clean
    end
end