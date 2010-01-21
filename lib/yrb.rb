# Process Yahoo! Resource Bundle format translation files and convert them to a hash.
#
# === Options
#
#   :unique    (true/false) Raise an error if a file contains duplicated values. Defaults to true.
#
module YRB
  
  module_function
  
  attr_accessor :path
  
  def load_file(path, options={})
    @path = path
    
    unless options.has_key?(:unique)
      options[:unique] = true
    end
    parse(File.read(path), options)
  end
  
  private
  
  # Is this line a valid comment in YRB?
  def comment?(line)
    line =~ /^[\s]*#/
  end

  # Is this line valid YRB syntax?
  #
  def key_and_value_from_line(line)
    if line =~ /^([^\=]+)=(.+)/
      return $1, $2.strip
    else
      return nil, nil
    end
  end

  # Parse YRB and add it to a hash.  Raise an error if the key already exists in the hash.
  #
  def parse(template, options={})
    @hash = {}
    lines = template.split("\n")
    lines.each do |line|
      unless comment?(line)
        key, value = key_and_value_from_line(line)
        if key
          if options[:unique] && @hash.has_key?(key)
            raise "Duplicate key error: #{key}"
          end
          @hash[key] = value
        end
      end
    end
    @hash
  end
end