# Title: Amber source code
# Author: Amber Team
# Date: 2018-11-07
# Code version: 0.11.1
# Availability: https://github.com/amberframework/amber

require "json"

# Flash message container.
class FlashContainer
  # Shard version.
  VERSION = "0.1.0"

  class_property key : String = "_flash"

  @store : Hash(String, String) = {} of String => String
  @read = [] of String
  @now = [] of String

  forward_missing_to @store

  # Creates FlashContainer instance based on stringified JSON.
  def self.from_session(json : String)
    new(Hash(String, String).from_json(json))
  rescue e : JSON::ParseException
    new
  end

  def self.from_session(_json : Nil)
    new
  end

  def initialize
  end

  def initialize(@store)
  end

  def fetch(key : String)
    @read << key
    @store.fetch(key, nil)
  end

  def fetch(key : Symbol)
    fetch(key.to_s)
  end

  def fetch(key : String, default_value : String?)
    @read << key
    @store.fetch(key, default_value)
  end

  def fetch(key : Symbol, default_value : String?)
    fetch(key.to_s, default_value)
  end

  def []=(key : Symbol, value : String)
    @store[key.to_s] = value
  end

  def []?(key : Symbol)
    fetch(key.to_s, nil)
  end

  def []?(key : String)
    fetch(key, nil)
  end

  def [](key : Symbol)
    fetch(key)
  end

  def each
    @store.each do |key, value|
      yield({key, value})
      @read << key
    end
  end

  def now(key, value : String?)
    @now << key
    self[key] = value
  end

  def keep(key = nil)
    @read.delete(key)
    @now.delete(key)
  end

  def to_session
    reject { |key, _| @read.includes?(key) || @now.includes?(key) }.to_json
  end
end
