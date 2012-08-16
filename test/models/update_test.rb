require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Update Model" do
  should 'construct a new instance' do
    @update = Update.new
    refute_nil @update
  end

  should "save an update" do
    port = ENV['PORT']

    name     = "#{Faker::Lorem.words(1).join(" ")}"
    version  = "#{rand(100)}.#{rand(100)}.#{rand(100)}"
    download = Download.new(:url => "http://localhost:#{port}/extensions/mod_#{name.downcase}/download/mod_#{name.downcase}-#{version}.zip")

    update = Update.new(:name => name, :description => Faker::Lorem.words(5).join(" "), 
      :element => "mod_#{name.downcase}", :type => 'module', :version => version, 
      :infourl => {:title => "#{name} #{version}", :value => 'http://localhost:#{port}/extensions/mod_#{name.downcase}'},
      :maintainer => Faker::Name.name, :maintainerurl => "http://#{Faker::Internet.domain_name}", :section => 'Updates')
    update.downloads << download

    assert update.save
  end

  should "save and then destroy an update" do
    port = ENV['PORT']

    name     = "#{Faker::Lorem.words(1).join(" ")}"
    version  = "#{rand(100)}.#{rand(100)}.#{rand(100)}"
    download = Download.new(:url => "http://localhost:#{port}/extensions/mod_#{name.downcase}/download/mod_#{name.downcase}-#{version}.zip")

    update = Update.new(:name => name, :description => Faker::Lorem.words(5).join(" "), 
      :element => "mod_#{name.downcase}", :type => 'module', :version => version, 
      :infourl => {:title => "#{name} #{version}", :value => 'http://localhost:#{port}/extensions/mod_#{name.downcase}'},
      :maintainer => Faker::Name.name, :maintainerurl => "http://#{Faker::Internet.domain_name}", :section => 'Updates')
    update.downloads << download

    assert update.save

    assert update.destroy 
  end
end