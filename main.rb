# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'car'
require_relative 'interface'
require_relative 'counter'

my_app = TrainApp.new
my_app.action
