# pull seed files as *.rb in db/seeds subfolder
Dir[Rails.root.join('db/seeds/*.rb')].sort.each do |file|
    puts "Seeding #{file.split('/').last}"
    require file
end