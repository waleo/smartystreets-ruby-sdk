require 'smartystreets_ruby_sdk/shared_credentials'
require 'smartystreets_ruby_sdk/static_credentials'
require '../lib/smartystreets_ruby_sdk/client_builder'
require '../lib/smartystreets_ruby_sdk/us_autocomplete_pro/lookup'

class USAutocompleteProExample
  Lookup = SmartyStreets::USAutocompletePro::Lookup

  def run
    # key = 'Your SmartyStreets Auth ID here'
    # hostname = 'Your SmartyStreets Auth Token here'

    # We recommend storing your secret keys in environment variables instead---it's safer!
    key = ENV['SMARTY_AUTH_WEB']
    referer = ENV['SMARTY_AUTH_REFERER']

    credentials = SmartyStreets::SharedCredentials.new(key, referer)

    # auth_id = ENV['SMARTY_AUTH_ID']
    # auth_token = ENV['SMARTY_AUTH_TOKEN']
    #
    # credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)

    # The appropriate license values to be used for your subscriptions
    # can be found on the Subscriptions page of the account dashboard.
    # https://www.smartystreets.com/docs/cloud/licensing
    client = SmartyStreets::ClientBuilder.new(credentials).with_licenses(['us-autocomplete-pro-cloud'])
                 .build_us_autocomplete_pro_api_client

    # Documentation for input fields can be found at:
    # https://smartystreets.com/docs/cloud/us-autocomplete-api

    lookup = Lookup.new('1042 W Center')
    lookup.add_state_filter('CO')
    lookup.add_state_filter('UT')
    lookup.add_city_filter('Denver')
    lookup.add_city_filter('Orem')
    lookup.max_results = 5
    lookup.prefer_ratio = 3
    lookup.source = "all"

    suggestions = client.send(lookup) # The client will also return the suggestions directly

    puts
    puts '*** Result with some filters ***'
    puts

    suggestions.each do |suggestion|
      puts "#{suggestion.street_line} #{suggestion.city}, #{suggestion.state}"
    end

  end
end

USAutocompleteProExample.new.run

