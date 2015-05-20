require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params
      parse_www_encoded_form(req.query_string)
      parse_www_encoded_form(req.body)
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    #[["user[address[street]", "main"], ["user[address[zip]]", 810384]]
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return if www_encoded_form.nil?
      arguments = URI::decode_www_form(www_encoded_form)
      arguments.each do |pair|
        pair[0] = parse_key(pair[0])
      end
      @params = build_params(arguments)
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end

    def build_params(data)
      params = {}
      data.each do |pair|
        keys = pair.first
        val = pair.last
        current = params
        keys.each_with_index do |key, idx|
          if idx == keys.length-1
            current[key] = val
          else
            current[key] ||= {}
            current = current[key]
          end
        end
      end
      params
    end
  end
end
