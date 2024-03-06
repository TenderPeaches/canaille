#!/usr/bin/env ruby

require "fileutils"
# path to your application root.
APP_ROOT = File.expand_path("..", __dir__)

def system!(*args)
  system(*args) || abort("\n== Command #{args} failed ==")
end

FileUtils.chdir APP_ROOT do
    puts "Dropping current db"
    # this just always sort of worked
    system! "rails db:drop:_unsafe"

    puts "Re-migrating"
    system! "rails db:migrate"

    puts "Re-seeding"
    system! "rails db:seed"

    puts "Re-migrating test"
    system! "rails db:migrate RAILS_ENV=test"

    puts "DB has been reset"
end
