require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Apiv1Controller" do
  context "JSON Requests" do
    setup do
      header 'Accept', 'application/json' 
    end

    should "return all updates" do
      get '/updates.json'
      assert last_response.status == 200

      updates = JSON.parse(last_response.body)
      assert !updates[0]['name'].blank?
      assert updates.length > 0
    end

    should "return a specific update by element name" do
      update = Update.first

      get "/updates/#{update.element}.json"
      assert last_response.status == 200

      updates = JSON.parse(last_response.body)
      assert !updates[0]['name'].blank?
      assert updates[0]['name'] == update.name
    end
  end

  context "XML Requests" do
    setup do
      header 'Accept', 'application/xml' 
    end

    should "return all updates" do
      get '/updates.xml'
      assert last_response.status == 200

      updates = Crack::XML.parse(last_response.body)['updates']
      assert !updates[0]['name'].blank?
      assert updates.length > 0
    end

    should "return a specific update by element name" do
      update = Update.first

      get "/updates/#{update.element}.xml"
      assert last_response.status == 200

      updates = Crack::XML.parse(last_response.body)['updates']
      assert !updates[0]['name'].blank?
      assert updates[0]['name'] == update.name
    end
  end
end