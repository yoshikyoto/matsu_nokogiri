require 'yaml'
require 'nokogiri'
require './infra/matsu-client.rb'

config = YAML.load_file('conf/config.yml')

matsu = MatsuClient.new(config[:matsui][:id], config[:matsui][:pass])

nokogiriDoc = matsu.test
puts nokogiriDoc.title

puts matsu.login
