require 'ffaker' 

ENV['PORT'] ||= '3000'
port = ENV['PORT']

unless Padrino.env == :production
  shell.say "Adding Component Updates. 3 to be exact"
  3.times do |i|
    name     = "#{Faker::Lorem.words(1).join(" ")}"
    version  = "#{rand(100)}.#{rand(100)}.#{rand(100)}"
    download = Download.new(:url => "http://localhost:#{port}/extensions/com_#{name.downcase}/download/com_#{name.downcase}-#{version}.zip")

    update = Update.new(:name => name, :description => Faker::Lorem.words(5).join(" "), 
      :element => "com_#{name.downcase}", :type => 'component', :version => version, 
      :infourl => {:title => "#{name} #{version}", :value => 'http://localhost:#{port}/extensions/com_#{name.downcase}'},
      :maintainer => Faker::Name.name, :maintainerurl => "http://#{Faker::Internet.domain_name}", :section => 'Updates')
    update.downloads << download

    update.save
  end

  shell.say "Adding Package Updates. 3 to be exact"
  3.times do |i|
    name     = "#{Faker::Lorem.words(1).join(" ")}"
    version  = "#{rand(100)}.#{rand(100)}.#{rand(100)}"
    download = Download.new(:url => "http://localhost:#{port}/extensions/pkg_#{name.downcase}/download/pkg_#{name.downcase}-#{version}.zip")

    update = Update.new(:name => name, :description => Faker::Lorem.words(5).join(" "), 
      :element => "pkg_#{name.downcase}", :type => 'package', :version => version, 
      :infourl => {:title => "#{name} #{version}", :value => 'http://localhost:#{port}/extensions/pkg_#{name.downcase}'},
      :maintainer => Faker::Name.name, :maintainerurl => "http://#{Faker::Internet.domain_name}", :section => 'Updates')
    update.downloads << download

    update.save
  end

  shell.say "Adding Module Updates. 3 to be exact"
  3.times do |i|
    name     = "#{Faker::Lorem.words(1).join(" ")}"
    version  = "#{rand(100)}.#{rand(100)}.#{rand(100)}"
    download = Download.new(:url => "http://localhost:#{port}/extensions/mod_#{name.downcase}/download/mod_#{name.downcase}-#{version}.zip")

    update = Update.new(:name => name, :description => Faker::Lorem.words(5).join(" "), 
      :element => "mod_#{name.downcase}", :type => 'module', :version => version, 
      :infourl => {:title => "#{name} #{version}", :value => 'http://localhost:#{port}/extensions/mod_#{name.downcase}'},
      :maintainer => Faker::Name.name, :maintainerurl => "http://#{Faker::Internet.domain_name}", :section => 'Updates')
    update.downloads << download

    update.save
  end

  shell.say "Adding Update Whose Name We Know: pkg_test"
  pkg_test = Update.find_by_element('pkg_test')
  unless pkg_test
    version  = "#{rand(100)}.#{rand(100)}.#{rand(100)}"
    download = Download.new(:url => "http://localhost:#{port}/extensions/pkg_test/download/pkg_test-#{version}.zip")

    update = Update.new(:name => 'test', :description => 'Packages Test', :element => 'pkg_test', :type => 'module', 
      :version => version, :infourl => {:title => "Packages Test 1.0.1", :value => 'http://localhost:#{port}/extensions/pkg_test'},
      :tags => 'stable', :maintainer => Faker::Name.name, :maintainerurl => "http://#{Faker::Internet.domain_name}", 
      :section => 'Updates')
    update.downloads << download

    update.save
  end
end