require 'uri'

module Phase5
  class Params

    def initialize(req, route_params = {})
      @params = parse_www_encoded_form(req.query_string)

      unless route_params.empty?
        @params = safe_merge(@params, route_params)
      end

      if req.body
        @params = safe_merge(@params, parse_www_encoded_form(req.body))
      end
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    def parse_www_encoded_form(www_encoded_form)
      return {} if www_encoded_form.nil?
      param_arrays = URI::decode_www_form(www_encoded_form)

      result = {}
      param_arrays.each do |(key, value)|
        nested_keys = parse_key(key)

        if nested_keys.length == 1
          result[nested_keys.first] = value
          next

        else
          nested_hash = value
          until nested_keys.empty? do
            nested_hash = {nested_keys.pop => nested_hash }
          end

          result = safe_merge(result, nested_hash)
        end
      end
      result
    end

    # allows lossless merge of nested hashes, provided no overlapping core values
    def safe_merge(hash1, hash2)
      hash1.merge(hash2) do |k,x,y|
        if x.is_a?(Hash)
          safe_merge(x, y)
        else
          x
        end
      end
    end

    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end

    class AttributeNotFoundError < ArgumentError; end;
  end
end
