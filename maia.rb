require 'oauth'
require 'restclient'
require 'json'

# Maia - Jira Release Creation Automation
# Purpose: This provides a simple way to create releases using Jira's OAuth1.0 interface
#
# It is required that you have already generated your certificate with openssl and 
# extracted the relevant *.pem, *.key, and *.pcks8 files and have run OAF2 to get your
# authorized token and token secret.

# TODO - Move key file locations to a configuration file
# load 'config.rb'

keyfile_path = "C:\\OpenSSL-Win64\\keys\\"
keyfile_root = "henrb028"

consumer_key = ""
line = ""
begin
	f =	File.open("#{keyfile_path}#{keyfile_root}.consumer")
	f.each do |line|
		consumer_key = consumer_key + line
	end
rescue
	abort "Failure reading consumer file!\n#{$!}\n#{keyfile_path}#{keyfile_root}"
ensure
	f.close unless f.nil?
end

opts={
    consumer_key:       consumer_key,
    site:               'https://jira.disney.com/',
    scheme:             :header,
    http_method:        :post,
    signature_method:   'RSA-SHA1',
    request_token_path: '/plugins/servlet/oauth/request-token',
    authorize_path:     '/plugins/servlet/oauth/authorize',
    access_token_path:  '/plugins/servlet/oauth/access-token'
}

private_key = ""
line = ""
begin
	f =	File.open("#{keyfile_path}#{keyfile_root}.key")
	f.each do |line|
		private_key = private_key + line
	end
rescue
	abort "Failure reading key file!\n#{$!}"
ensure
	f.close unless f.nil?
end

consumer = OAuth::Consumer.new(opts[:consumer_key],private_key,opts)


	# Prepare the request
	# Subsequent connections, where you already have an access token and secret
token = ""
line = ""
begin
	f = File.open("#{keyfile_path}#{keyfile_root}.token")
	f.each do |line|
			token = token + line
		end
rescue
	abort "Failure reading token file!\n#{$!}"
ensure
	f.close unless f.nil?
end

tokensecret = ""
line = ""
begin
	f = File.open("#{keyfile_path}#{keyfile_root}.tokensecret")
	f.each do |line|
			tokensecret = tokensecret + line
		end
rescue
	abort "Failure reading tokensecret file!\n#{$!}"
ensure
	f.close unless f.nil?
end

access_token = OAuth::AccessToken.new(consumer, token, tokensecret)
 

# Read in the dates file
# For each date in the dates file
version_date = "2019-10-31"
version_name = "EPC #{version_date} Test"
#   create a release in Jira following the Appropriate naming convention 

payload = {
    name: version_name,
    archived: false,
    released: false,
    releaseDate: version_date,
    projectId: 10091
}

# This attaches the access token to a RestClient call
RestClient.add_before_execution_proc do |req, params|
  access_token.sign! req
end
 
	# Call Jira
begin
	puts RestClient.get("https://jira.disney.com/rest/api/2/project")
rescue
	puts "#{$!}"
	puts "consumer: #{consumer_key}"
	puts "private key: #{private_key}"
	puts "token: #{token}"
	puts "tokensecret: #{tokensecret}" 
ensure
	RestClient.reset_before_execution_procs
end